//
//  UIColor+MSYExtension.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/30.
//

import UIKit

extension UIColor {
    /// cell 背景颜色
    public class var msy_bgCellColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1)
                } else {
                    return .white
                }
            }
        } else {
            return .white
        }
    }
}
