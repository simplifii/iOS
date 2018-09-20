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
    
//    static func loginUser(username: String, password: String, completion: @escaping (Result<APIToken>) -> Void){
//
//        Alamofire.request(APIRouter.loginUser(email: email, password: password)).responseJSON(completionHandler: { response in
//
//            // check that header has a token string
//            guard let token = response.response?.allHeaderFields[UserConstants.authentication] as? String
//
//                else {return completion(Result.failure(APIError.noJsonReceived))}
//
//            completion(Result.success(token))
//        })
//
//    }
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
