//
//  CartItem.swift
//  MacroFit
//
//  Created by Chandresh Singh on 03/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CartItem {
    let name:String
    let quantity:Int
    let mealInfo:[String:Any]
}
