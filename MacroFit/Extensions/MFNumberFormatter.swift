//
//  MFNumberFormatter.swift
//  MacroFit
//
//  Created by Jon Pierce-Ruhland on 12/8/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class MFNumberFormatter: NSObject {
    static let formatter = MFNumberFormatter()
    
    private var weightFormatter: NumberFormatter!
    
    override init() {
        weightFormatter = NumberFormatter()
        weightFormatter.maximumFractionDigits = 1
    }
    
    func stringFromWeight(grams g: Double?) -> String? {
        //Just go to pounds
        return g != nil ? stringFromWeight(pounds: g! / 453.2) : nil
    }
    
    func stringFromWeight(pounds p: Double?) -> String? {
        return p != nil ? weightFormatter.string(from: NSNumber(value: p!)) : nil
    }
    
    var weightUnitString: String { return "lbs" }
}
