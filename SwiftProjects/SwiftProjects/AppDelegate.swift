//
//  AppDelegate.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    lazy var tabBarCtrConfig: MSYTabBarCtrConfig = {
        let tabBarCtrConfig = MSYTabBarCtrConfig()
        
        return tabBarCtrConfig
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        createAppWindow()
        
        return true
    }

    private func createAppWindow() {
        if #available(iOS 13.0, *) {
            
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = tabBarCtrConfig.tabBarCtr
            window?.makeKeyAndVisible()
            
            UITabBar.appearance().backgroundColor = UIColor.white
            UITabBar.appearance().tintColor = UIColor(red:255.0/255.0, green:102.0/255.0, blue:0, alpha:1.0)
        }
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

