//
//  Datamodeltocolleps.swift
//  MacroFit
//
//  Created by Sachin Arora on 15/11/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import Foundation
class Detamodeltocolleps  {
    var headerName: String?
    //    var subType = [String]()
    var isExpandable: Bool = false
    
    init(headerName: String, isExpandable: Bool) {
        self.headerName = headerName
        //        self.subType = subType
        self.isExpandable = isExpandable
        
    }
    
}
