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

func removeAllNotification() {
    //移除所有的通知
    let notifications : Array<UILocalNotification> = UIApplication.shared.scheduledLocalNotifications!
    for notification  in notifications {
        UIApplication.shared.cancelLocalNotification(notification)
    }
}

func removeNotification(notificationInfo:EventModel) {
    let notifications : Array<UILocalNotification> = UIApplication.shared.scheduledLocalNotifications!
    for notification  in notifications {
        if notification.fireDate?.timeIntervalSince1970 == notificationInfo.remindDate  &&
            notification.alertBody == notificationInfo.eventTitle{
            //时间和提示信息相等，则移除该通知
            UIApplication.shared.cancelLocalNotification(notification)
        }
    }
}

func addLocalNotification(title:String!, fireDate:Date!) -> Void {
//    let date = Date.init(timeIntervalSinceNow: 20)
//    UIApplication.shared.cancelAllLocalNotifications()
    let notification = UILocalNotification()
    notification.fireDate = fireDate
    notification.timeZone = NSTimeZone.default
    notification.soundName = "test.caf"
    notification.alertBody = title
    notification.applicationIconBadgeNumber = 1
    notification.alertAction = "ds"
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH"
    let dateStr = dateFormatter.string(from: fireDate)
    let keyStr = dateStr.appending(title)
    notification.userInfo = [kNotificationkey:keyStr]
    notification.applicationIconBadgeNumber = 1
    UIApplication.shared.scheduleLocalNotification(notification)
}
