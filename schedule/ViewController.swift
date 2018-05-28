//
//  ViewController.swift
//  schedule
//
//  Created by zj－db0548 on 2017/6/15.
//  Copyright © 2017年 魔方. All rights reserved.
//

import UIKit
import EventKit



class ViewController: UIViewController {

    
    
//    var isKeyboardShow : Bool = false
//    @IBOutlet var titleLabel : UILabel!
//    @IBOutlet var textView : UITextView!
//    @IBOutlet var datePicker : UIDatePicker!
//    @IBOutlet weak var comfireBtn: UIButton!
//    @IBOutlet weak var hideKeyBoardView: TouchesView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        datePicker.datePickerMode = UIDatePickerMode.dateAndTime;
//        hideKeyBoardView.delegate = self;
//        self.addNotification()
//        self.reset()
//    }
//
//    func addNotification() -> Void {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
//         NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
//    }
//    
//    func keyboardShow() {
//        isKeyboardShow = true
//    }
//    
//    func keyboardHide() {
//        isKeyboardShow = false
//    }
//    
//    //******************** About UI Event ***********************//
//    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
//        //判断是否小于当前时间
//        let date = sender.date
//        let interval = date.timeIntervalSinceNow
//        if interval < delayTime {
//            //提示不能少于半小时
//            let peridictDate = Date.init(timeIntervalSinceNow: delayTime)
//            sender.setDate(peridictDate, animated: true)
//        }
//    }
//    
//    
//    @IBAction func actionConfirm(_ sender: UIButton) {
//        if textView.text == nil || textView.text == "" {
//            let alter = simpleCancelAler(title: "内容不能为空", message: nil)
//            self.present(alter!, animated: true, completion: nil);
//            return
//        }
//        
//        if datePicker.date.timeIntervalSinceNow <= 0 {
//            let alter = simpleCancelAler(title: "提醒时间不能小于当前时间", message: nil)
//            self.present(alter!, animated: true, completion: nil);
//            return
//        }
//        
//        //添加通知成功
//        let date = datePicker.date;
//        addLocalNotification(title: textView.text, fireDate: date)
//        let alter = simpleCancelAler(title: "事件已添加", message: nil)
//        self.present(alter!, animated: true, completion: nil);
//        reset()
//    }
//    
//    func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        //判断
//        if !isKeyboardShow {
//            return nil
//        }
//        
//        let textFrame = textView.frame;
//        if textFrame.contains(point) {
//            let layoutManager = textView.layoutManager
//            var newPoint = hideKeyBoardView.convert(point, to: textView)
//            newPoint.x -= textView.textContainerInset.left
//            newPoint.y -= textView.textContainerInset.top
//            let index = layoutManager.characterIndex(for: newPoint, in:textView.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
//            
//            let length = (textView.text! as NSString).length
//            if index < (length - 1) {
//                 return nil
//            }
//        }
//        self.view.endEditing(true)
//        return hideKeyBoardView;
//    }
//    
//    func reset() {
//        textView.text = nil
//        let peridictDate = Date.init(timeIntervalSinceNow: delayTime)
//        datePicker.setDate(peridictDate, animated: true)
//    }
}


