//
//  TDItem.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/31.
//

import Foundation

struct TDItem {
    let title: String
    let itemDescription: String?
    let timestamp: Double?
    let location: TDLocation?
    
    // plist related
    private let titleKey = "titleKey"
    private let itemDescriptionKey = "itemDescriptionKey"
    private let timestampKey = "timestampKey"
    private let locationKey = "locationKey"
    
    var plistDict: [String:Any] {
        var dict = [String:Any]()
        
        dict[titleKey] = title
        if let itemDescription = itemDescription {
            dict[itemDescriptionKey] = itemDescription
        }
        if let timestamp = timestamp {
            dict[timestampKey] = timestamp
        }
        if let location = location {
            let locationDict = location.plistDict
            dict[locationKey] = locationDict
        }
        return dict
    }
    
    init(title: String, itemDescription: String? = nil, timeStamp: Double? = nil, location: TDLocation? = nil) {
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timeStamp
        self.location = location
    }
    
    init?(dict: [String: Any]) {
        guard let title = dict[titleKey] as? String else {
            return nil
        }
        
        self.title = title
        self.itemDescription = dict[itemDescriptionKey] as? String
        self.timestamp = dict[timestampKey] as? Double
        if let locationDict = dict[locationKey] as? [String: Any] {
            self.location = TDLocation(dict: locationDict)
        } else {
            self.location = nil
        }
    }
}

extension TDItem: Equatable {
    static func ==(lhs: TDItem, rhs: TDItem) -> Bool {
        return lhs.title == rhs.title && lhs.location?.name == rhs.location?.name
    }
}
