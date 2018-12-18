//
//  CoursesAndChallengesApiResponse.swift
//  MacroFit
//
//  Created by mac on 12/13/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import ObjectMapper

class CoursesAndChallengesApiResponse: BaseResponse {

    var response:CoursesAndChallengesModel!
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        response <- map["response"]
    }
}
