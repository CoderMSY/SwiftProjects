//
//  ATShareMacro.swift
//  SwiftDemo
//
//  Created by SimonMiao on 2019/4/24.
//  Copyright © 2019 avatar. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let ATButtonColor = UIColor(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
let ATDownColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)

// iphone X
let AT_IS_IPHONE_4 = SCREEN_HEIGHT == 480.0 ? true : false
let AT_IS_IPHONE_5 = SCREEN_HEIGHT == 568.0 ? true : false
let AT_IS_IPHONE_6 = SCREEN_HEIGHT == 667.0 ? true : false
let AT_IS_IPHONE_6Plus = SCREEN_HEIGHT == 736.0 ? true : false
let AT_IS_IPHONE_X = SCREEN_HEIGHT == 812.0 ? true : false
let AT_IS_IPHONE_XRorXSMax = SCREEN_HEIGHT == 896.0 ? true : false

// LBFMNavBarHeight
//let ATNavBarHeight : CGFloat = (AT_IS_IPHONE_X || AT_IS_IPHONE_XRorXSMax) ? 88 : 64
// LBFMTabBarHeight
let ATTabBarHeight : CGFloat = (AT_IS_IPHONE_X || AT_IS_IPHONE_XRorXSMax) ? 49 + 34 : 49

