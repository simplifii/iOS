//
//  Challenge.swift
//  MacroFit
//
//  Created by ajay dubedi on 25/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import Foundation
import ObjectMapper

class ChallengeModel: BaseResponse
{
    
    var challengeId: Int!
    var title: String!
    var tags: String!
    var photo: String!
    var friends: String!

    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        challengeId <- map["challenge_id"]
        title <- map["title"]
        tags <- map["tags"]
        photo <- map["photo"]
        friends <- map["friends"]
    }
//    var photo:String?
//    var id:String?
//    var title:String?
//    var description:String?
//    var participants_count:String?
//    var is_scoring_in_time:Bool?
//    var score_unit:String?
//    var tags:String?
//    var the_more_the_better:Bool?
    
}

extension ChallengeModel: BaseTableCell{
    func getCellType() -> TableCellType {
        return TableCellType.CHALLENGE
    }
}
