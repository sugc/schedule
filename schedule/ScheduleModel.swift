//
//  ScheduleModel.swift
//  schedule
//
//  Created by sugc on 2019/7/1.
//  Copyright © 2019 魔方. All rights reserved.
//

//? 如何记录每天完成的情况

import Foundation

enum scheduleType : Int {
    case unDefined = -1    //未定义
    case OneTime = 0       //一次性任务， 只分完成未完成
    case Progress = 1      //持续性任务， 按照进度算
    case Regular = 2       //每日性任务， 如每天跑步
}

class ScheduleModel : NSObject {
    //
    var key : String!
    var eventTitle : String!
    var starTime : TimeInterval!
    var endTime : TimeInterval!
    var needTime : TimeInterval!
    var progress : CGFloat!
    var subModels : Array<ScheduleModel>?
    var type : Int  = -1
    var shoulUnfold : Bool = false
    
    override init() {
        super.init()
    }
    
    init(data : Dictionary<String, Any>!) {
        super.init()
        
        key = data["key"] as? String
        eventTitle = data["eventTitle"] as? String
        starTime = data["starTime"] as? TimeInterval
        endTime = data["endTime"] as? TimeInterval
        progress = data["progress"] as? CGFloat
        
        
        var sub = Array<ScheduleModel>()
        let array = data["subModels"] as! Array<Dictionary<String, Any>>
        
        for dic in array {
            let subSchedule = ScheduleModel.init(data: dic)
            sub.append(subSchedule)
        }
        subModels = sub
    }
    
    //保存时使用
    func toDictionary() -> Dictionary<String, Any> {
        return Dictionary()
    }
    
    func getTimeString() -> String! {
        return "07-02 - 07-15"
    }
    
}



