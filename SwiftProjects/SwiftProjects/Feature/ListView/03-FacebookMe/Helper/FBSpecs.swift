//
//  FBSpecs.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/30.
//

import UIKit

public struct FBSpecs {
    public struct FBColor {
        public let tint = UIColor(hex: 0x3b5998)
        public let red = UIColor.red
        public let white = UIColor.white
        public let black = UIColor.black
        public let gray = UIColor.lightGray
    }
    
    public struct FBFontSize {
        public let tiny: CGFloat = 10
        public let small: CGFloat = 12
        public let regular: CGFloat = 14
        public let large: CGFloat = 16
    }
    
    public struct FBFont {
        private static let regularName = "Helvetica Neue"
        private static let boldName = "Helvetica Neue Bold"
        
        public let tiny = UIFont(name: regularName, size: FBSpecs.fontSize.tiny)
        public let small = UIFont(name: regularName, size: FBSpecs.fontSize.small)
        public let regular = UIFont(name: regularName, size: FBSpecs.fontSize.regular)
        public let large = UIFont(name: regularName, size: FBSpecs.fontSize.large)
        public let smallBold = UIFont(name: boldName, size: FBSpecs.fontSize.small)
        public let regularBold = UIFont(name: boldName, size: FBSpecs.fontSize.regular)
        public let largeBold = UIFont(name: boldName, size: FBSpecs.fontSize.large)
    }
    
    public struct FBImageName {
        public let friends = "fb_friends"
        public let events = "fb_events"
        public let groups = "fb_groups"
        public let education = "fb_education"
        public let townHall = "fb_town_hall"
        public let instantGames = "fb_games"
        public let settings = "fb_settings"
        public let privacyShortcuts = "fb_privacy_shortcuts"
        public let helpSupport = "fb_help_and_support"
        public let placeholder = "fb_placeholder"
    }
    
    public static var color: FBColor {
      return FBColor()
    }
    
    public static var fontSize: FBFontSize {
      return FBFontSize()
    }
    
    public static var font: FBFont {
      return FBFont()
    }
    
    public static var imageName: FBImageName {
      return FBImageName()
    }
}
