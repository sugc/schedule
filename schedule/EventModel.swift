//
//  EventModel.swift
//  schedule
//
//  Created by zj－db0548 on 2017/6/21.
//  Copyright © 2017年 魔方. All rights reserved.
//

import Foundation



enum EventType: Int {
    case remind = 0
    case calendar = 1
    case alarm = 2
}

struct EventModel {
    //根据json初始化
    init() {
        
    }
    init(json:String) {
        //数据库处理？
    }
    var eventTitle : String!
    var createDate : TimeInterval!      //事件添加时间
    var remindDate : TimeInterval!    //事件提醒时间
}

