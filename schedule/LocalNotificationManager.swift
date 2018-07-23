//
//  LocalNotificationManager.swift
//  schedule
//
//  Created by zj－db0548 on 2017/6/21.
//  Copyright © 2017年 魔方. All rights reserved.
//

import Foundation
import UIKit

let kNotificationkey : String = "kNotificationkey"

class LocalNotificationManager {
    
    
    
}

func removeNotification() {
    let notifications = UIApplication.shared.scheduledLocalNotifications
    
    //获取当前的通知
    
//    UIApplication.shared.cancelLocalNotification(<#T##notification: UILocalNotification##UILocalNotification#>)
}

func removeNotification(notificationInfo:EventModel) {
    let notifications = UIApplication.shared.scheduledLocalNotifications
    
}

func addLocalNotification(title:String!, fireDate:Date!) -> Void {
//    let date = Date.init(timeIntervalSinceNow: 20)
    UIApplication.shared.cancelAllLocalNotifications()
    let notification = UILocalNotification()
    notification.fireDate = fireDate
    notification.timeZone = NSTimeZone.default
    notification.soundName = "test.caf"
    notification.alertBody = title
    notification.applicationIconBadgeNumber = 1
    notification.alertAction = "ds"
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    let dateStr = dateFormatter.string(from: fireDate)
    let keyStr = dateStr.appending(title)
    notification.userInfo = [kNotificationkey:keyStr]
    notification.applicationIconBadgeNumber = 1
    UIApplication.shared.scheduleLocalNotification(notification)
}
