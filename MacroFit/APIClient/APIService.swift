//
//  APIService.swift
//  MacroFit
//
//  Created by Chandresh Singh on 20/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import Alamofire
import SwiftyJSON

struct APIService {
//    static let APIToken = "sdfghjk" // TODO
    
    static func loginUser(username: String, password: String, completion: @escaping (Bool, String) -> Void){
        Alamofire.request(APIRouter.loginUser(username: username, password: password))
            .validate(statusCode: 200..<501)
            .validate(contentType: ["application/json"])
            .responseJSON(completionHandler: { response in
            switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if let status_code = response.response?.statusCode {
                        if status_code == 200 {
                            UserDefaults.standard.set(json["token"].stringValue, forKey: UserConstants.userToken)
                            UserDefaults.standard.set(json["response"]["unique_code"].stringValue, forKey: UserConstants.userCardUniqueCode)
                            completion(true, json["msg"].stringValue)
                        } else {
                            if let msg = json["msg"].string {
                                completion(false, msg)
                            } else {
                                completion(false, "Internal Server Error")
                            }
                        }
                    }
                case .failure(let error):
                    print(error)
                    completion(false, "Internal Server Error")
            }
        })

    }
    
    static func activityLevels(completion: @escaping (Bool, String, JSON) -> Void){
        Alamofire.request(APIRouter.activityLevels())
            .validate(statusCode: 200..<501)
            .validate(contentType: ["application/json"])
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if let status_code = response.response?.statusCode {
                        if status_code == 200 {
                            completion(true, json["msg"].stringValue, json["response"]["data"])
                        } else {
                            if let msg = json["msg"].string {
                                completion(false, msg, [])
                            } else {
                                completion(false, "Internal Server Error", [])
                            }
                        }
                    }
                case .failure(let error):
                    print(error)
                    completion(false, "Internal Server Error", [])
                }
            })
        
    }
    
    static func fitnessGoals(completion: @escaping (Bool, String, JSON) -> Void){
        Alamofire.request(APIRouter.fitnessGoals())
            .validate(statusCode: 200..<501)
            .validate(contentType: ["application/json"])
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if let status_code = response.response?.statusCode {
                        if status_code == 200 {
                            completion(true, json["msg"].stringValue, json["response"]["data"])
                        } else {
                            if let msg = json["msg"].string {
                                completion(false, msg, [])
                            } else {
                                completion(false, "Internal Server Error", [])
                            }
                        }
                    }
                case .failure(let error):
                    print(error)
                    completion(false, "Internal Server Error", [])
                }
            })
        
    }
    
    static func updateCustomerBasicDetails(age: String, weight: String, height: String, activity_level: String?, goal: String, gender: String, per_day_cal_burn: String, goal_note: String?, completion: @escaping (Bool, String) -> Void) {
        Alamofire.request(APIRouter.updateCustomerBasicDetails(age: age, weight: weight, height: height, activity_level: activity_level, goal: goal, gender: gender, per_day_cal_burn: per_day_cal_burn, goal_note: goal_note))
            .validate(statusCode: 200..<501)
            .validate(contentType: ["application/json"])
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if let status_code = response.response?.statusCode {
                        if status_code == 200 {
                            completion(true, json["msg"].stringValue)
                        } else {
                            if let msg = json["msg"].string {
                                completion(false, msg)
                            } else {
                                completion(false, "Internal Server Error")
                            }
                        }
                    }
                case .failure(let error):
                    print(error)
                    completion(false, "Internal Server Error")
                }
            })
        
    }
    
    
//
//    static func getCards(request: URLRequestConvertible, completion: @escaping (Result<[User]>) -> Void){
//
//        Alamofire.request(request).responseJSON(completionHandler: { response in
//
//            switch(response.result){
//
//            case let .success(value):
//
//                let Users: [User] = parseUsers(json: JSON(value))
//
//                completion(Result.success(Users))
//
//            case .failure:
////                completion(Result.failure(APIError.noJsonReceived))
//                completion(Result.failure((response.result.error as NSError?)!))
//            }
//        })
//    }
//
//    static func parseUsers(json: JSON) -> [User]{
//
//        guard let  json = json[NetworkingConstants.data].array else{
//            return []
//        }
//
//        return []
//
//        return json.flatMap(User.init)
//    }
}
