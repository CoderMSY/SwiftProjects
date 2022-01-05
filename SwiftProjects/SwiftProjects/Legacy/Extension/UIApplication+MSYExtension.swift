//
//  UIApplication+MSYExtension.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/4.
//

import UIKit

extension UIApplication {
    public class var msy_keyWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter { $0.activationState == .foregroundActive}
                .compactMap { $0 as? UIWindowScene }.first?.windows
                .filter { $0.isKeyWindow }.first
            
            return keyWindow
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    class func msy_setStatusBar(color: UIColor) {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//            scene?.statusBarManager?.statusBarStyle = barStyle
//            scene?.statusBarManager?.bar
        } else {
//            UIApplication.shared.statusBarStyle = barStyle
            
            let statusBarWindow : UIView = UIApplication.shared.value(forKey: "statusBarWindow") as! UIView
            let statusBar : UIView = statusBarWindow.value(forKey: "statusBar") as! UIView
            if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
                statusBar.backgroundColor = color
            }
        }
    }
//    public class var msy_statusHeight: CGFloat {
//        if #available(iOS 13.0, *) {
//            let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//            scene?.statusBarManager?.statusBarStyle = UIStatusBarStyle.lightContent
//        } else {
//            UIApplication.shared.statusBarStyle = .lightContent
//
//        }
//    }
}

/** Objective-C
 + (UIWindow *)zyl_keyWindow
 {
     if (@available(iOS 13.0, *)) {
         for (UIWindowScene *windowScene in UIApplication.sharedApplication.connectedScenes) {
             if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                 for (UIWindow *window in windowScene.windows) {
                     if (window.isKeyWindow) {
                         return window;
                     }
                 }
                 break;
             }
         }
     } else {
         return UIApplication.sharedApplication.keyWindow;
     }
     
     return nil;
 }

 */
