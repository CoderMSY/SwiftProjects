//
//  FBMeUser.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/30.
//

import Foundation

class FBMeUser {
    var name: String
    var avatarName: String
    var education: String
    
    init(name: String, avatarName: String = "bayMax", education: String) {
        self.name = name
        self.avatarName = avatarName
        self.education = education
    }
}
