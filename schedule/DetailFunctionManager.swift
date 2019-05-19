//
//  DetailFunctionManager.swift
//  schedule
//
//  Created by sugc on 2019/1/25.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation


class DetailFunctionManager : NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private var configArray : Array<Dictionary<String, Any> >!
    
    override init() {
        super.init()
        self.setConfig()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return configArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if configArray.count > section {
            let array : Array<Any>? = (configArray[section]["cellData"] as? Array<Any>)
            return array?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : DetailFuncTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "deatilFuncCell") as? DetailFuncTableViewCell
        if cell == nil {
            cell = DetailFuncTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "deatilFuncCell")
        }
        
        if configArray.count > indexPath.section {
            let dic = configArray[indexPath.section]
            let cellArray : Array<Any> = dic["cellData"] as! Array<Any>
            if cellArray.count > indexPath.row {
                let cellParam : Dictionary<String, Any> = cellArray[indexPath.row] as! Dictionary<String, Any>
                let rightIconName = cellParam["rightImage"] as? String
                cell?.rightIconImage = UIImage.init(named: rightIconName ?? "")
                
                let leftIconName = cellParam["leftImage"] as? String
                cell?.leftIconImage = UIImage.init(named: leftIconName ?? "")
                
                
                let leftTitle = cellParam["title"] as? String
                cell?.leftTitle = leftTitle
            }
        }
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if configArray.count > indexPath.section {
            let dic = configArray[indexPath.section]
            let cellArray : Array<Any> = dic["cellData"] as! Array<Any>
            if cellArray.count > indexPath.row {
                let cellParam : Dictionary<String, Any> = cellArray[indexPath.row] as! Dictionary<String, Any>
                let action = cellParam["action"] as? String
                if action == "goClock" {
                    //去番茄闹钟
                    self.goColock()
                }
                
                if action == "goBirthDay" {
                    //去生日提醒
                }
                
                if action == "goSettings" {
                    //去基本设置
                }
            }
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func goColock() {
        //
        let tomatoVC = TomatoViewController()
        (UIApplication.shared.delegate as! AppDelegate).navigationViewController.pushViewController(tomatoVC, animated: true)
    }
    
    func goBorthDay() {
        //
    }
    
    func goSettings() {
        //
    }
    
    func setConfig() {
        configArray = [
            [
                "header" : "",
                "cellData" : [
                    [
                        "title" : "番茄时钟",
                        "leftImage" : "",
                        "rightImage" : "icon_right_arrow",
                        "type" : "",
                        "action" : "goClock"
                    ],
                    
                    [
                        "title" : "生日提醒",
                        "leftImage" : "",
                        "rightImage" : "icon_right_arrow",
                        "type" : "",
                        "action" : "goBirthDay"
                    ],
                    
                    [
                        "title" : "设置",
                        "leftImage" : "",
                        "rightImage" : "icon_right_arrow",
                        "type" : "",
                        "action" : "goSettings"
                    ],
                    
                    [
                        "title" : "挑战记录",
                        "leftImage" : "",
                        "rightImage" : "icon_right_arrow",
                        "type" : "",
                        "action" : "goSettings"
                    ],
                ]
            ],
            
            [
                "header" : "",
                "cellData" : [
                    [
                        "title" : "意见反馈",
                        "leftImage" : "",
                        "rightImage" : "icon_right_arrow",
                        "type" : "",
                        "action" : "goSettings"
                    ],
                    
                    [
                        "title" : "关于我们",
                        "leftImage" : "",
                        "rightImage" : "icon_right_arrow",
                        "type" : "",
                        "action" : "goSettings"
                    ],
                ]
            ]
        ]
    }
}
