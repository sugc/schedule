//
//  LocalNotificationManager.swift
//  schedule
//
//  Created by zj－db0548 on 2017/6/21.
//  Copyright © 2017年 魔方. All rights reserved.
//

import Foundation
import UIKit

class LocalNotificationManager {
    
    
    
}

func addLocalNotification(title:String!, fireDate:Date!) -> Void {
    UIApplication.shared.cancelAllLocalNotifications()
    let notification = UILocalNotification()
    notification.fireDate = fireDate
    notification.timeZone = NSTimeZone.default
    notification.soundName = "test.caf"
    notification.alertBody = title
    notification.alertAction = "ds"
    notification.userInfo = ["us":"d"]
    //notification.applicationIconBadgeNumber = notification.applicationIconBadgeNumber + 1
    UIApplication.shared.scheduleLocalNotification(notification)
}
