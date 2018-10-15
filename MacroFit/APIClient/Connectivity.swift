//
//  Connectivity.swift
//  MacroFit
//
//  Created by Chandresh Singh on 15/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import Foundation
import Alamofire
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
