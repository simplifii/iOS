//
//  NSObject.swift
//  DISC
//
//  Created by mac on 11/22/18.
//  Copyright © 2018 DISC. All rights reserved.
//

import Foundation

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
