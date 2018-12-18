//
//  HttpObject.swift
//  BrewBound
//
//  Created by Nitin Bansal on 20/05/17.
//  Copyright © 2017 Nitin Bansal. All rights reserved.
//

import UIKit
enum RtStatus : Int {
    case success
    case failed_UNKNOWN
    case failed_CONNECTION_ERROR
    case failed_SESSION_EXPIRED
    case failed_NO_INTERNET
    case failed_STATUS_FALSE
    case failed_PARSE_EXCEPTION
    case failed_NO_DATA_EXCEPTION
}
class HttpObject {
    var methodType : METHODS = METHODS.GET
    var strUrl: String = ""
    var strMethodType: String = "GET"
    var params = [String:Any]()
    var headers = [String: String]()
    var user = [String: Int]()
    var strtaskCode: TASKCODES = TASKCODES.GET_DATA
    var json : NSMutableDictionary?
    var isArray = false
    var roletype = "1";
    var fileRequest : FileRequest?
    
    func setJson(dicJson : NSMutableDictionary){
        self.json = dicJson;
    }
    
    func addParam(_ key: String, andValue value: Any) {
        self.params.updateValue(value,forKey:key)
    }
    
    func setJsonContentType() {
        self.headers.updateValue("application/json",forKey:"Content-Type")
    }
    
    //    func getToken() -> String {
    //        return  UserDefaults.standard.string(forKey: "logintoken")!
    //    }
    
    
    func addHeader(_ key: String, value: String) {
        self.headers.updateValue(value,forKey:key)
    }
    
    func addAuthHeader() {
        if let token = UserDefaults.standard.string(forKey: UserConstants.userToken){
            if(!token.isEmpty){
                self.headers.updateValue("Bearer \(token)", forKey :  "Authorization");
            }
        }
    }
    
    func addUserHeader() {
    }
    
    func setPostMethod(){
        self.strMethodType = "POST"
        self.methodType = METHODS.POST;
    }
    
    func setPutMethod(){
        self.strMethodType = "PUT"
        self.methodType = METHODS.PUT
    }
    
    init(){
        self.params = [String:String]()
        self.headers = [String: String]()
        self.addHeader("Content-Type", value:"application/json")
        addAuthHeader()
        //addAuthHeader()
    }
    
    init(url pageUrl: String, withTaskCode taskCode: TASKCODES) {
        self.params = [String:String]()
        self.headers = [String: String]()
        self.addHeader("Content-Type", value:"application/json")
        self.strUrl = pageUrl
        self.strtaskCode = taskCode
        //addAuthHeader()
        
    }
}

class FileRequest{
    var data : Data?
    var keyName = "file"
    var fileName = "file.jpg"
    var mimeType = "image/jpg"
}

