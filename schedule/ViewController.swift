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
        addalarmClock()
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
            
            let alarmStarDate = Date(timeIntervalSinceNow: 20)
            let alarmEndDate = Date(timeIntervalSinceNow: 30)
            
            let event = EKEvent(eventStore: eventDB)
            event.title = "哈哈哈"
            event.startDate = alarmStarDate
            event.endDate = alarmStarDate
            
            let alarm = EKAlarm(absoluteDate: alarmStarDate)
//            alarm.relativeOffset = 5
            event.addAlarm(alarm)
            event.calendar = eventDB.defaultCalendarForNewEvents
            
            
            do {
                try eventDB.save(event, span: EKSpan.thisEvent)
            }catch {
            
            }
        }

    }

}


