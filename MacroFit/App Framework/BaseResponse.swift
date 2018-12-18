//
//  BaseResponse.swift
//  Reach-Swift
//
//  Created by Bansals on 28/06/17.
//  Copyright © 2017 Kartik. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseResponse: BaseMapperModel {
    var msg : String!
    
    required init?(map: Map){
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        msg <- map["msg"];
    }
}

class CheckUserResponse : BaseResponse{
    var data : Bool!
    
    required init?(map: Map){
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"];
    }
}

class FileUploadResponse: BaseResponse{
    var data: FileUrlData?
    required init?(map: Map){
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"];
    }
}

class FileUrlData: BaseMapperModel{
    var urls: [String]?
    
    required init?(map: Map){
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        urls <- map["urls"];
    }
}
