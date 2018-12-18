//
//  DateExtension.swift
//  Reach-Swift
//
//  Created by Nitin Bansal on 12/07/17.
//  Copyright © 2017 Kartik. All rights reserved.
//

import Foundation
extension NSDate {
    class func relativeTimeInString(value: TimeInterval) -> String {
        func getTimeData(value: TimeInterval) -> (count: Int64, suffix: String) {
            print("value = \(value)")
            let count = Int64(floor(value))
            let suffix = count != 1 ? "s" : ""
            print("count = \(count)")
            return (count: count, suffix: suffix)
        }
        
        let value = -value
        switch value {
        case 0...15: return "just now"
            
        case 0..<60:
            let timeData = getTimeData(value: value)
            return "\(timeData.count) second\(timeData.suffix) ago"
            
        case 0..<3600:
            let timeData = getTimeData(value: value/60)
            return "\(timeData.count) min\(timeData.suffix) ago"
            
        case 0..<86400:
            let timeData = getTimeData(value: value/3600)
            return "\(timeData.count) hour\(timeData.suffix) ago"
            
        case 0..<604800:
            let timeData = getTimeData(value: value/86400)
            return "\(timeData.count) day\(timeData.suffix) ago"
            
        default:
            let timeData = getTimeData(value: value/604800)
            return "\(timeData.count) week\(timeData.suffix) ago"
        }
    }
}


