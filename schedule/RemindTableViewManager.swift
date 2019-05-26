//
//  RemindTableViewManager.swift
//  schedule
//
//  Created by sugc on 2019/1/20.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation

class RemindTableViewManager : NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var dataArray : Array<EventModel> = []
    weak var tableView : UITableView?
    weak var ViewController : UIViewController?
    override init() {
        super.init()
//        dataArray = DBManager.singleTon().allEvent()
    }
    
    //重载数据
    func reloadDataWithDate(date:Date) {
        dataArray = DBManager.singleTon().eventForDate(date: date)
        tableView?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
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
            
            self.ViewController?.present(alertController, animated: true, completion: nil)
            
        }else {
            _ = self.deleteReminderInIndexPath(path: path)
        }
    }
    
    func deleteReminderInIndexPath(path : IndexPath) -> EventModel {
        let model = dataArray.remove(at: path.row)
        DBManager.singleTon().deleteEvent(eventModel: model)
        tableView?.deleteRows(at: [path], with: UITableViewRowAnimation.top)
        return model;
    }
}
