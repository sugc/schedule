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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let nav = UINavigationController.init()
        self.window = UIWindow()
        window?.rootViewController = nav;
        //开始root
        let story = UIStoryboard.init(name: "Reminder", bundle: nil)
        let homeView = story.instantiateViewController(withIdentifier: "ReminderViewController") as! ReminderViewController
        
        nav.pushViewController(homeView, animated: false)
        
        // Override point for customization after application launch.
        
//        if UIApplication.shared.currentUserNotificationSettings?.types == nil {
            let setting1 = UIUserNotificationSettings(types: UIUserNotificationType.sound, categories: nil)
            let setting2 = UIUserNotificationSettings(types: UIUserNotificationType.alert, categories: nil)
            let setting3 = UIUserNotificationSettings(types: UIUserNotificationType.badge, categories: nil)


            UIApplication.shared.registerUserNotificationSettings(setting1)
            UIApplication.shared.registerUserNotificationSettings(setting2)
            UIApplication.shared.registerUserNotificationSettings(setting3)

        
        
//        }

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
        
    }
}

