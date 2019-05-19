//
//  ReminderManager.swift
//  schedule
//
//  Created by zj－db0548 on 2017/6/21.
//  Copyright © 2017年 魔方. All rights reserved.
//

import Foundation
import NotificationCenter
import EventKit

func addalarmEvent(date:NSDate!, message:String!)-> Void  {
    let eventDB = EKEventStore()
    
    eventDB.requestAccess(to: EKEntityType.event) { (granted, error) in
        
        if !granted {
            return
        }
        
        print("request")
        
        let alarmStarDate = Date(timeIntervalSinceNow: 10)
        //        let alarmEndDate = Date(timeIntervalSinceNow: 30)
        
        let event = EKEvent(eventStore: eventDB)
        event.title = message
        
        event.startDate = alarmStarDate
        event.endDate = alarmStarDate
        
        let alarm = EKAlarm(absoluteDate: alarmStarDate)
        event.addAlarm(alarm)
        
        event.calendar = eventDB.defaultCalendarForNewEvents
        
        do {
            try eventDB.save(event, span: EKSpan.thisEvent)
        }catch {
            
        }
    }
}

//闹钟
func addAlarmClock() -> Void {
    let notification = UILocalNotification()
    notification.fireDate = Date(timeIntervalSinceNow: 10)
    notification.repeatInterval = NSCalendar.Unit.minute
    notification.timeZone = NSTimeZone.default
    notification.soundName = "test.caf"
    notification.alertBody = "哈哈哈"
    notification.alertAction = "ds"
    notification.userInfo = ["us":"d"]
    notification.applicationIconBadgeNumber = notification.applicationIconBadgeNumber + 1
    UIApplication.shared.scheduleLocalNotification(notification)
}

//添加提醒
func addReminder(message:String!)  {
    let eventDB = EKEventStore()
    eventDB.requestAccess(to: EKEntityType.reminder) { (granted, error) in
        if !granted {
            return
        }
        
        let alarmStarDate = Date(timeIntervalSinceNow: 10)
        let alarmEndDate = Date(timeIntervalSinceNow: 30)
        let reminder = EKReminder(eventStore: eventDB)
        
        reminder.title = message
        reminder.calendar = eventDB.defaultCalendarForNewReminders()
        
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.system
        
        var flags = Set<Calendar.Component>()
        flags.insert(Calendar.Component.year)
        flags.insert(Calendar.Component.month)
        flags.insert(Calendar.Component.day)
        flags.insert(Calendar.Component.hour)
        flags.insert(Calendar.Component.minute)
        flags.insert(Calendar.Component.second)
        
        let dateCmp = calendar.dateComponents(flags, from: alarmStarDate)
        let endDateCmp = calendar.dateComponents(flags, from: alarmEndDate)
        
        reminder.startDateComponents = dateCmp
        reminder.dueDateComponents = endDateCmp
        reminder.priority = 1
        
        let alarm = EKAlarm(absoluteDate: alarmStarDate)
        reminder.addAlarm(alarm)

        do {
            try eventDB.save(reminder, commit: true)
        }catch {
            //添加失败
        }
    }
}

