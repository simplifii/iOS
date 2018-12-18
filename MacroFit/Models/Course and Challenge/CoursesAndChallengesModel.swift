//
//  CoursesAndChallenges.swift
//  MacroFit
//
//  Created by mac on 12/13/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import ObjectMapper

class CoursesAndChallengesModel: BaseResponse {

    var courses: [CourseModel]!
    var challenges: [ChallengeModel]!
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        courses <- map["courses"]
        challenges <- map["challenges"]
    }
}
