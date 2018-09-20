//
//  APIRouter.swift
//  MacroFit
//
//  Created by Chandresh Singh on 20/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import Alamofire
import SwiftyJSON

enum APIRouter: URLRequestConvertible {
    
    case createUser(name: String, email: String, password: String, phone: String, zip_code: String)
    case loginUser(username: String, password: String)
    
    var path: String {
        
        switch self {
            
        case .loginUser:
            return NetworkingConstants.login
            
        case .createUser:
            return NetworkingConstants.users
        }
    }
    
    var body : [String: Any]{
        
        var bodyDict: [String: Any] = [:]
        
        switch self {

            case let .createUser(name: name, email: email, password: password, phone: phone, zip_code: zip_code):
                bodyDict["entity"] = "Customer"
                bodyDict["action"] = "Create"
                bodyDict["master_key"] = "addcustomer"
                bodyDict["name"] = name
                bodyDict["email"] = email
                bodyDict["mobile"] =  phone
                bodyDict["password"] = password
                bodyDict["referral_code"] = ""
                bodyDict["zipcode"] = zip_code
                break
            default:
                print("no action")
        }
        
        return bodyDict
    }
    
    
    var parameters: [String: Any] {
        
        var paramDict : [String: Any] = [:]
        
        switch self {
            
        case let .loginUser(username, password):
            paramDict["username"] = username
            paramDict["password"] = password
            break
            
        default:
            break
        }
        
        return paramDict
    }
    
    
    var method: HTTPMethod {
        switch self {
        case .createUser, .loginUser:
            return .post
        }
    }
    
    
    var headers: HTTPHeaders {
        
        var headers : [String:String] = [:]
        
        switch self {
            case .createUser, .loginUser:
                  headers[UserConstants.content_type] = "application/json"
            default:
                break
        }
        
        return headers
        
    }
    
    var encoding: ParameterEncoding {
        switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try NetworkingConstants.baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        if body.count > 0 {
            let jsonString = JSON(body).rawString()
            let data = (jsonString?.data(using: .utf8))! as Data
            urlRequest.httpBody = data
        }
        
        switch method {
            case .get:
                return try URLEncoding.methodDependent.encode(urlRequest, with: parameters)
            default:
                return try URLEncoding.methodDependent.encode(urlRequest, with: nil)
        }
    }
}
