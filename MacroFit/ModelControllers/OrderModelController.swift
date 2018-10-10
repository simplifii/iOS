//
//  OrderModelController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 03/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import Foundation

class OrderModelController {
    var address = Address(
        addressLineOne: "",
        addressLineTwo: "",
        zipcode: ""
    )
    
    var credits:Int = 0
    
    var cartItems:[CartItem] = []
    
    var totalItemsQuantity:Int = 0
    var totalAmount:Int = 0
    
    var entryNote:String = ""
    
    var orderCardId:String = ""
    var orderCardUniqueCode:String = ""
    
    var deliveryDateFormatted:String = ""
    var deliveryDateFrom:String = ""
    var deliveryDateTo:String = ""
}
