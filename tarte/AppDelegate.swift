//
//  AppDelegate.swift
//  tarte
//
//  Created by onox on 2018/12/12.
//  Copyright © 2018 onox. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let storyBoard:UIStoryboard = self.grabStoryboad()
        if let window = window {
            window.rootViewController = storyBoard.instantiateInitialViewController()
        }
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func grabStoryboad() -> UIStoryboard {
        var storyBoard = UIStoryboard()
        let height = UIScreen.main.bounds.height
        
        if height <= 568 {
            storyBoard = UIStoryboard(name: "iPhoneSE", bundle: nil)
        } else if 568 <= height && height <= 667 {
            storyBoard = UIStoryboard(name: "Main", bundle: nil)
        } else if 667 <= height && height <= 736 {
            storyBoard = UIStoryboard(name: "iPhone8Plus", bundle: nil)
        } else if 736 <= height && height <= 812 {
            storyBoard = UIStoryboard(name: "iPhoneXS", bundle: nil)
        } else if 812 <= height && height <= 896 {
            storyBoard = UIStoryboard(name: "iPhoneXR", bundle: nil)
        } else {
            storyBoard = UIStoryboard(name: "Main", bundle: nil)
        }
        
        return storyBoard
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


}

