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
            
            print("request")
        }

    }

}


