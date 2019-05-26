//
//  CalendarViewController.swift
//  schedule
//
//  Created by sugc on 2019/1/20.
//  Copyright © 2019 魔方. All rights reserved.
//

import Foundation

class CalendarViewController : UIViewController {
    //日历控制器
    var calendarView : WZYCalendarView!
    var tableView : UITableView!
    var addBtn : UIButton!
    var settingBtn : UIButton!
    var selectedYear : Int?
    var selectedMonth : Int?
    var selectedDay : Int?
    
    let tableManager : RemindTableViewManager! = RemindTableViewManager.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        tableManager.ViewController = self
        let navigatorH : CGFloat = 44
        let btnW : CGFloat = 30
        let settingBtnFrame = CGRect.init(x: 20,
                                          y: iPhoneXSafeDistanceTop + (navigatorH - btnW) / 2.0,
                                          width: btnW,
                                          height: btnW)
        settingBtn = UIButton.init(frame: settingBtnFrame)
        settingBtn.addTarget(self, action: #selector(goSetting), for: UIControlEvents.touchUpInside)
        settingBtn.setImage(UIImage.init(named: "icon_setting_none"), for: UIControlState.normal)
        
        let addBtnFrame = CGRect.init(x: ScreenWidth - 20 - btnW,
                                      y: iPhoneXSafeDistanceTop + (navigatorH - btnW) / 2.0,
                                      width: btnW,
                                      height: btnW)
        addBtn = UIButton.init(frame: addBtnFrame)
        addBtn.addTarget(self, action: #selector(addNewEvent), for: UIControlEvents.touchUpInside)
        addBtn.setImage(UIImage.init(named: "icon_add"), for: UIControlState.normal)
        
        let width = ScreenWidth
        let origin = CGPoint.init(x: 0, y: iPhoneXSafeDistanceTop + navigatorH)
    
        weak var weakSelf = self
        calendarView = WZYCalendarView.init(frameOrigin: origin, width: width)
        calendarView.didSelectDayHandler = {(year, month, day) in
            weakSelf?.selectedYear = year
            weakSelf?.selectedMonth = month
            weakSelf?.selectedDay = day
            weakSelf?.setPlan(year: year, month: month, day: day)
        }
        

        self.view.addSubview(calendarView)
        self.view.addSubview(addBtn)
        self.view.addSubview(settingBtn)
        
        let seperator : CGFloat = 20
        let tableFrame = CGRect.init(x: 0,
                                     y: calendarView.bottom + seperator,
                                     width: ScreenWidth,
                                     height: ScreenHeight - iPhoneXSafeDistanceBottom - calendarView.bottom - navigatorH - seperator)
        tableView = UITableView.init(frame: tableFrame)
        tableView.delegate = tableManager
        tableView.dataSource = tableManager
        tableView.tableFooterView = UIView.init()
        tableManager.tableView = tableView
        self.view.addSubview(tableView)
        
        let date = Date.init()
        self.setPlansForCalculateDate(date: date)
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        selectedYear = dateFormatter.calendar.component(Calendar.Component.year, from: date)
        selectedMonth = dateFormatter.calendar.component(Calendar.Component.month, from: date)
        selectedDay = dateFormatter.calendar.component(Calendar.Component.day, from: date)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if selectedDay != nil && selectedMonth != nil && selectedYear != nil {
            setPlan(year: selectedYear!, month: selectedMonth!, day: selectedDay!)
        }
    }
    
    //添加新的事件
    func addNewEvent() -> Void {
        
        let story = UIStoryboard.init(name: "Reminder", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "ReminderViewController") as! ReminderViewController
        //        nav.pushViewController(homeView, animated: false)
        self.present(vc, animated: true) {
            
        }
    }
    
    //去设置
    func goSetting() -> Void {
        
    }
    
    func setPlan(year : Int, month : Int, day : Int) {
        let str = String.init(format: "%ld-%ld-%ld", year,month,day)
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let date = dateFormatter.date(from: str)
        setPlansForCalculateDate(date: date!)
    }

    
    func setPlansFor(date : Date) {
        //获取数据，并填充
        tableManager.reloadDataWithDate(date: date)
    }
    
    func setPlansForCalculateDate(date : Date) {
        let timeInterval = Double(TimeZone.current.secondsFromGMT()) + date.timeIntervalSince1970
        let realTime = Int(timeInterval / (24 * 60 * 60)) * 24 * 60 * 60 - TimeZone.current.secondsFromGMT()
        let realDate = Date.init(timeIntervalSince1970: TimeInterval(realTime))
        setPlansFor(date: realDate)
    }
}


