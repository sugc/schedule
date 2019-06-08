//
//  AppDelegate.swift
//  schedule
//
//  Created by zj－db0548 on 2017/6/15.
//  Copyright © 2017年 魔方. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationViewController : UINavigationController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        GADMobileAds.configure(withApplicationID: "ca-app-pub-9435427819697575~6435656153")
        
        navigationViewController = UINavigationController.init()
        let tab = UITabBarController.init()
        
        self.window = UIWindow()
        window?.rootViewController = navigationViewController;
        navigationViewController.navigationBar.isHidden = true
        navigationViewController.interactivePopGestureRecognizer?.isEnabled = false
        //开始root
//        let story = UIStoryboard.init(name: "Reminder", bundle: nil)
//        let homeView = story.instantiateViewController(withIdentifier: "ReminderViewController") as! ReminderViewController
//        nav.pushViewController(homeView, animated: false)
//        homeView.title = "提醒"
        
        let calendarVC = CalendarViewController()
        let tabBar1 = UITabBarItem.init(title: "日历", image: UIImage.init(named: "icon_tab_calendar"), selectedImage: nil)
        
        calendarVC.tabBarItem = tabBar1
        
        let sleepVC = SleepAudioViewController()
        let tabBar2 = UITabBarItem.init(title: "助眠", image: UIImage.init(named: "icon_tab_sleep"), selectedImage: nil)
        sleepVC.tabBarItem = tabBar2
        
        let detailVC = DetailFunctionViewController()
        let tabBar3 = UITabBarItem.init(title: "更多", image: UIImage.init(named: "icon_tab_more"), selectedImage: nil)
        detailVC.tabBarItem = tabBar3
        
        navigationViewController.viewControllers = [tab]
        tab.viewControllers = [calendarVC,sleepVC, detailVC];

        addLocalNotification()
        AudioPlayer.initSession()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        let types = notificationSettings.types
        if  types.rawValue == 0{
            //显示弹窗
            return;
        }
    }
    
    //收到通知
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        //判断是否在前台
        if application.applicationState == UIApplication.State.active {
            
        }
        //

    }
    
    
    //注册本地通知
    func addLocalNotification() {
        
        let settings = UIApplication.shared.currentUserNotificationSettings!
        let types = settings.types
        if  types.rawValue ==  7
        {
            //判断是否需要在请求通知权限
            return;
        }


        let category = UIMutableUserNotificationCategory()
        category.identifier = "magic_schedule_category"
        
        let setting1 = UIUserNotificationSettings(types: UIUserNotificationType.sound, categories: [category])
        let setting2 = UIUserNotificationSettings(types: UIUserNotificationType.alert, categories: [category])
        let setting3 = UIUserNotificationSettings(types: UIUserNotificationType.badge, categories: [category])
        UIApplication.shared.registerUserNotificationSettings(setting1)
        UIApplication.shared.registerUserNotificationSettings(setting2)
        UIApplication.shared.registerUserNotificationSettings(setting3)
    }
    
}

