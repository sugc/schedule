//
//  ReminderViewController.swift
//  schedule
//
//  Created by sugc on 2018/5/27.
//  Copyright © 2018年 魔方. All rights reserved.
//

import Foundation

import UIKit
import EventKit

class ReminderViewController : UIViewController, ToucesViewDelegate {
    
    var isKeyboardShow : Bool = false
    let delayTime : TimeInterval = 60 * 10
    var swipeGesture : UISwipeGestureRecognizer!
    @IBOutlet weak var bgImageView : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var textView : UITextView!
    @IBOutlet weak var datePicker : UIDatePicker!
    @IBOutlet weak var comfireBtn: UIButton!
    @IBOutlet weak var hideKeyBoardView: TouchesView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime;
        hideKeyBoardView.delegate = self;
        self.navigationController?.navigationBar.isHidden = true
        self.addNotification()
        self.reset()
        swipeGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(swipeToLeft(gesture:)))
        swipeGesture.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeGesture)
        
        
    }
    
    func addNotification() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIApplication.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIApplication.keyboardDidHideNotification, object: nil)
    }
    
    @objc func keyboardShow() {
        isKeyboardShow = true
    }
    
    @objc func keyboardHide() {
        isKeyboardShow = false
    }
    
    //******************** About UI Event ***********************//
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        //判断是否小于当前时间
        let date = sender.date
        let interval = date.timeIntervalSinceNow
        if interval < delayTime {
            let peridictDate = Date.init(timeIntervalSinceNow: delayTime)
            sender.setDate(peridictDate, animated: true)
        }
    }
    
    
    @IBAction func actionConfirm(_ sender: UIButton) {
        if textView.text == nil || textView.text == "" {
            let alter = simpleCancelAler(title: "内容不能为空", message: nil )
            self.present(alter!, animated: true, completion: nil);
            return
        }
        
        if datePicker.date.timeIntervalSinceNow <= 0 {
            let alter = simpleCancelAler(title: "提醒时间不能小于当前时间", message: nil)
            self.present(alter!, animated: true, completion: nil);
            return
        }

        //添加通知成功
        let date = datePicker.date
        addLocalNotification(title: textView.text, fireDate: date)
        
        //数据库处理
        var event = EventModel.init()
        event.createDate = Date().timeIntervalSince1970
        event.remindDate = date.timeIntervalSince1970
        event.eventTitle = textView.text
        DBManager.singleTon().saveEventToDB(eventModel: event)
        
        //
        let alter = simpleCancelAler(title: "事件已添加", message: nil) { (action) in
            self.actionClose(nil)
        }
        self.present(alter!, animated: true, completion: nil);
        reset()
    }
    
    @IBAction func actionClose(_ sender: UIButton?) {
        self.dismiss(animated: true) {
            
        }
    }
    
    func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        //判断
        if !isKeyboardShow {
            return nil
        }
        
        let textFrame = textView.frame;
        if textFrame.contains(point) {
            let layoutManager = textView.layoutManager
            var newPoint = hideKeyBoardView.convert(point, to: textView)
            newPoint.x -= textView.textContainerInset.left
            newPoint.y -= textView.textContainerInset.top
            let index = layoutManager.characterIndex(for: newPoint, in:textView.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
            
            let length = (textView.text! as NSString).length
            if index < (length - 1) {
                return nil
            }
        }
        self.view.endEditing(true)
        return hideKeyBoardView;
    }
    
    func reset() {
        textView.text = nil
        let peridictDate = Date.init(timeIntervalSinceNow: delayTime)
        datePicker.setDate(peridictDate, animated: true)

    }
    
    @objc func swipeToLeft(gesture:UISwipeGestureRecognizer) {
        let story = UIStoryboard.init(name: "Reminder", bundle: nil)
        let remindListVC = story.instantiateViewController(withIdentifier: "RemindListViewController") as! RemindListViewController
        self.navigationController?.pushViewController(remindListVC, animated: true)
    }
}
