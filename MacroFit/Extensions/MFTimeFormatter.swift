//
//  MFTimeFormatter.swift
//  MacroFit
//
//  Created by Jon Pierce-Ruhland on 11/28/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class MFTimeFormatter: NSObject {
    static let formatter = MFTimeFormatter()
    
    func durationString(fromSeconds seconds: TimeInterval) -> String? {
        return durationString(fromSeconds: Int(seconds))
    }
    
    ///Returns a string in the style 12h34m56s
    func durationString(fromSeconds seconds: Int) -> String {
        let h = seconds / 3600
        let m = (seconds / 60) % 60
        let s = seconds % 60
        
        var res = ""
        if h > 0 {
            res.append("\(h)h")
        }
        if m > 0 {
            res.append("\(m)m")
        }
        if s > 0 {
            res.append("\(s)s")
        }
        return res
    }
    
    ///Returns a string in the style 12:34:56,
    func clockStyleDurationString(fromSeconds ti: TimeInterval, forceHours: Bool? = false) -> String {
        let seconds = Int(ti)
        let h = seconds / 3600
        let m = (seconds / 60) % 60
        let s = seconds % 60
        
        var res = ""
        if h > 0 {
            if h < 10 {
                res.append("0")
            }
            res.append("\(h):")
        } else if forceHours ?? false {
            res.append("00:")
        }
        if m > 0 {
            if m < 10 {
                res.append("0")
            }
            res.append("\(m):")
        } else {
            res.append("00:")
        }
        if s > 0 {
            if s < 10 {
                res.append("0")
            }
            res.append("\(s)")
        } else {
            res.append("00")
        }
        return res
    }
}
