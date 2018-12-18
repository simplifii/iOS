//
//  NavUtil.swift
//  Reach-Swift
//
//  Created by Nitin Bansal on 16/08/17.
//  Copyright © 2017 Kartik. All rights reserved.
//

import UIKit

class NavUtil: NSObject {
    static func getBarButton(image : String, target : Any?, selector : Selector)->UIBarButtonItem{
        return UIBarButtonItem(image: UIImage(named: image), style: .plain, target: target, action: selector)
    }
    
    
}
