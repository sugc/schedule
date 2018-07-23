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
        dataArray = DBManager.singleTon().allEvent()!
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
           print("cell init")
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
    
}
