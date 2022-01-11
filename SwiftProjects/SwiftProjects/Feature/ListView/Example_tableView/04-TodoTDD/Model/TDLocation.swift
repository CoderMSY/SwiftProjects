//
//  TDLocation.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/31.
//

import Foundation
import CoreLocation

struct TDLocation {
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    // plist
    private let nameKey = "nameKey"
    private let latitudeKey = "latitudeKey"
    private let longitudeKey = "longitudeKey"
    
    var plistDict: [String : Any] {
        var dict = [String : Any]()
        
        dict[nameKey] = name
        if let coordinate = coordinate {
            dict[latitudeKey] = coordinate.latitude
            dict[longitudeKey] = coordinate.longitude
        }
        
        return dict
    }
    
    init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
    init?(dict: [String : Any]) {
        guard let name = dict[nameKey] as? String else { return nil }
        
        let coordinate: CLLocationCoordinate2D?
        if let latitude = dict[latitudeKey] as? CLLocationDegrees,
            let longitude = dict[longitudeKey] as? CLLocationDegrees {
            coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        } else {
            coordinate = nil
        }
        
        self.name = name
        self.coordinate = coordinate
    }
}

extension TDLocation: Equatable {
    static func == (lhs: TDLocation, rhs: TDLocation) -> Bool {
        return lhs.name == rhs.name && lhs.coordinate?.latitude == rhs.coordinate?.latitude && lhs.coordinate?.longitude == rhs.coordinate?.longitude
    }
}
