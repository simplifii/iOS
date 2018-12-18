//
//  FontUtil.swift
//  Yello Bus
//
//  Created by Nitin Bansal on 30/05/17.
//  Copyright © 2017 Nitin Bansal. All rights reserved.
//

import UIKit

class FontUtil: NSObject {

    static let LIGHT = "GOTHAM-LIGHT"
    static let MEDIUM = "GOTHAM-LIGHT"
    static let REGULAR = "GOTHAM-LIGHT"
    static func getFont(fontName : String, fontSize : CGFloat)->UIFont{
        return UIFont(name: fontName, size: fontSize)!;
    }
}
