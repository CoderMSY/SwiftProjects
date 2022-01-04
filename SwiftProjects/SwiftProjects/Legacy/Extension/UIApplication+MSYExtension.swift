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
