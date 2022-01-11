//
//  FBTableKeys.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/30.
//

import Foundation

public struct FBTableKeys {
    static let Section = "section"
    static let Rows = "rows"
    static let ImageName = "imageName"
    static let Title = "title"
    static let SubTitle = "subTitle"
    static let seeMore = "See More..."
    static let addFavorites = "Add Favorites..."
    static let logout = "Log Out"
    
    static func populate(withUser user: FBMeUser) -> [[String: Any]] {
        return [
            [
                FBTableKeys.Rows: [
                    [FBTableKeys.ImageName: user.avatarName,
                     FBTableKeys.Title: user.name,
                     FBTableKeys.SubTitle: "View your profile"],
                ]
            ],
            [
                FBTableKeys.Rows: [
                    [FBTableKeys.ImageName: FBSpecs.imageName.friends, FBTableKeys.Title: "Friends"],
                    [FBTableKeys.ImageName: FBSpecs.imageName.events, FBTableKeys.Title: "Events"],
                    [FBTableKeys.ImageName: FBSpecs.imageName.groups, FBTableKeys.Title: "Groups"],
                    [FBTableKeys.ImageName: FBSpecs.imageName.education, FBTableKeys.Title: user.education],
                    [FBTableKeys.ImageName: FBSpecs.imageName.townHall, FBTableKeys.Title: "Town Hall"],
                    [FBTableKeys.ImageName: FBSpecs.imageName.instantGames, FBTableKeys.Title: "Instant Games"],
                    [FBTableKeys.Title: FBTableKeys.seeMore]
                ]
            ],
            [
                FBTableKeys.Section: "FAVORITES",
                FBTableKeys.Rows: [
                    [FBTableKeys.Title: FBTableKeys.addFavorites]
                ]
            ],
            [
                FBTableKeys.Rows: [
                    [FBTableKeys.ImageName: FBSpecs.imageName.settings, FBTableKeys.Title: "Settings"],
                    [FBTableKeys.ImageName: FBSpecs.imageName.privacyShortcuts, FBTableKeys.Title: "Privacy Shortcuts"],
                    [FBTableKeys.ImageName: FBSpecs.imageName.helpSupport, FBTableKeys.Title: "Help and Support"]
                ]
            ],
            [
                FBTableKeys.Rows: [
                    [FBTableKeys.Title: FBTableKeys.logout]
                ]
            ]
        ]
    }
}
