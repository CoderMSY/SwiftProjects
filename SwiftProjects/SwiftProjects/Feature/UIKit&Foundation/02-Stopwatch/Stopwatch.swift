//
//  Stopwatch.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/29.
//

import Foundation

class Stopwatch: NSObject {
    var counter: Double
    var timer: Timer
    
    override init() {
        counter = 0.0
        timer = Timer()
    }
}
