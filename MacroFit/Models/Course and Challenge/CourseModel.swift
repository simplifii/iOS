//
//  Courses.swift
//  MacroFit
//
//  Created by mac on 12/13/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import ObjectMapper

class CourseModel: BaseResponse {

    var courseId: Int!
    var title: String!
    var trainerName: String!
    var tags: String!
    var photo: String!
    var priceInCents: Int!
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        courseId <- map["course_id"]
        title <- map["title"]
        trainerName <- map["trainer_name"]
        tags <- map["tags"]
        photo <- map["photo"]
        priceInCents <- map["price_in_cents"]
    }
}

extension CourseModel: BaseTableCell{
    func getCellType() -> TableCellType {
        return TableCellType.COURSE
    }
}
