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
    
    func durationString(fromSeconds seconds: Int) -> String? {
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
}
