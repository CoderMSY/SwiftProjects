//
//  UIView+MSYExtension.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2022/1/4.
//

import UIKit

extension UIView {
    public class var msy_safeAreaTop: CGFloat {
        return UIApplication.msy_keyWindow?.safeAreaInsets.top ?? 0
    }
    public class var msy_safeAreaBottom: CGFloat {
        return UIApplication.msy_keyWindow?.safeAreaInsets.bottom ?? 0
    }
    
    public class var msy_statusHeight: CGFloat {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            return scene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.size.height
        }
    }
    
    public class var msy_navBarHeight: CGFloat {
        //navigationController?.navigationBar.bounds.size.height iOS15时包含状态栏高度
        return 44.0
    }
}
