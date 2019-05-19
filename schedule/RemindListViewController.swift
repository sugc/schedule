//
//  RemindListViewController.swift
//  schedule
//
//  Created by sugc on 2018/6/22.
//  Copyright © 2018年 魔方. All rights reserved.
//

import Foundation
import UIKit

//展示所有事件的列表--> 左滑删除
class RemindListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView : UITableView!
    var dataArray : Array<EventModel> = []
    //按照时间排序，滚动到最新一个事件
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray = DBManager.singleTon().allEvent()
        if dataArray.count <= 0 {
            //背景显示当前无提醒事件
            
        }
//        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "listViewCell")
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "listViewCell")

        if cell == nil {
           cell = UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: "listViewCell")
        }
        
        let evetModel = dataArray[indexPath.row]
        cell!.textLabel?.text = evetModel.eventTitle
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = Date.init(timeIntervalSince1970: evetModel.remindDate)
        let str = formatter.string(from:date)
        cell!.detailTextLabel?.text = str
        return cell!
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction.init(style: UITableViewRowActionStyle.default, title: "删除") { (action, path) in
            //删除一个通知
            self.removeReminderInIndexPath(path: path)
        }
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func removeReminderInIndexPath(path : IndexPath) -> Void {
        //判断是否已经通知过
        let eventModel = dataArray[path.row];
        if eventModel.remindDate > Date().timeIntervalSince1970 {
            //未提醒过的事件，显示提醒
            let okAction = UIAlertAction.init(title: "删除", style: UIAlertActionStyle.default, handler: { (action) in
               let model =  self.deleteReminderInIndexPath(path: path)
                removeNotification(notificationInfo: model)

            })
            let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: { (action) in
                
            })
            
            let alertController = UIAlertController.init(title: "删除后将不提醒该事件，是否确定删除", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            
        }else {
            _ = self.deleteReminderInIndexPath(path: path)
        }
    }
    
    func deleteReminderInIndexPath(path : IndexPath) -> EventModel {
        let model = dataArray.remove(at: path.row)
        DBManager.singleTon().deleteEvent(eventModel: model)
        tableView.deleteRows(at: [path], with: UITableViewRowAnimation.top)
        return model;
    }
}
