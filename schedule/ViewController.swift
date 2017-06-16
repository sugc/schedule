//
//  ViewController.swift
//  schedule
//
//  Created by zj－db0548 on 2017/6/15.
//  Copyright © 2017年 魔方. All rights reserved.
//

import UIKit

import EventKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        addalarmClock()
        addReminder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func addalarmClock()-> Void  {
        let eventDB = EKEventStore()
        
        eventDB.requestAccess(to: EKEntityType.event) { (granted, error) in
            
            if !granted {
                return
            }
                
            print("request")
            
            let alarmStarDate = Date(timeIntervalSinceNow: 10)
            let alarmEndDate = Date(timeIntervalSinceNow: 30)
            
            let event = EKEvent(eventStore: eventDB)
            event.title = "哈哈哈"
            
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
    
    func addReminder()  {
        let eventDB = EKEventStore()
        
        
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
        
//        eventDB.requestAccess(to: EKEntityType.reminder) { (granted, error) in
//            
//            if !granted {
//                return
//            }
//            
//            print("request")
//            
//            let alarmStarDate = Date(timeIntervalSinceNow: 10)
//            let alarmEndDate = Date(timeIntervalSinceNow: 30)
//            
//            let reminder = EKReminder(eventStore: eventDB)
//            reminder.title = "hehehe"
//            reminder.calendar = eventDB.defaultCalendarForNewReminders()
//            
//            var calendar = Calendar.current
//            calendar.timeZone = NSTimeZone.system
//            
//            var flags = Set<Calendar.Component>()
//            flags.insert(Calendar.Component.year)
//            flags.insert(Calendar.Component.month)
//            flags.insert(Calendar.Component.day)
//            flags.insert(Calendar.Component.hour)
//            flags.insert(Calendar.Component.minute)
//            flags.insert(Calendar.Component.second)
//            
//            let dateCmp = calendar.dateComponents(flags, from: alarmStarDate)
//            let endDateCmp = calendar.dateComponents(flags, from: alarmEndDate)
//            
//            reminder.startDateComponents = dateCmp
//            reminder.dueDateComponents = endDateCmp
//            reminder.priority = 1
//            
//            
//            let alarm = EKAlarm(absoluteDate: alarmStarDate)
//            reminder.addAlarm(alarm)
//            
//           
//            
//            
//            do {
//                try eventDB.save(reminder, commit: true)
//            }catch {
//                
//            }
//        }
    }

}


