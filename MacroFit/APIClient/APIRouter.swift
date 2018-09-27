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
    
    case createUser(name: String, email: String, password: String, phone: String, zip_code: String, promocode: String?)
    case loginUser(username: String, password: String)
    case activityLevels()
    case fitnessGoals()
    case updateCustomerBasicDetails(age: String, weight: String, height: String, activity_level: String?, goal: String, gender: String, per_day_cal_burn: String, goal_note: String?)
    case updateCustomerRecommendedMacros(meals_per_day: String, snacks: String)
    case getRecommendedDailyMacros()
    case updateDietaryPreferences(dietary_preference: String, diet_note: String?)
    case orderPlacementDetails()
    case getMealsMenu()
    
    var path: String {
        
        switch self {
            case .activityLevels:
                return NetworkingConstants.activityLevels
            
            case .loginUser:
                return NetworkingConstants.login
            
            case .createUser, .updateCustomerBasicDetails, .updateCustomerRecommendedMacros, .getRecommendedDailyMacros, .updateDietaryPreferences:
                return NetworkingConstants.users
            
            case .fitnessGoals:
                return NetworkingConstants.fitnessGoals
            case .orderPlacementDetails:
                return NetworkingConstants.orderPlacementDetails
            case .getMealsMenu:
                return NetworkingConstants.meals
        }
    }
    
    var body : [String: Any]{
        
        var bodyDict: [String: Any] = [:]
        
        switch self {

        case let .createUser(name: name, email: email, password: password, phone: phone, zip_code: zip_code, promocode: promocode):
                bodyDict["entity"] = "Customer"
                bodyDict["action"] = "Create"
                bodyDict["master_key"] = "addcustomer"
                bodyDict["name"] = name
                bodyDict["email"] = email
                bodyDict["mobile"] =  phone
                bodyDict["password"] = password
                bodyDict["referral_code"] = promocode
                bodyDict["zipcode"] = zip_code
                break
            case let .loginUser(username: username, password: password):
                bodyDict["username"] = username
                bodyDict["password"] = password
                break
        case let .updateCustomerBasicDetails(age: age, weight: weight, height: height, activity_level: activity_level, goal: goal, gender: gender, per_day_cal_burn: per_day_cal_burn, goal_note: goal_note):
                bodyDict["card_unique_code"] = UserDefaults.standard.string(forKey: UserConstants.userCardUniqueCode)
                bodyDict["action"] = "Update"
                bodyDict["age"] = age
                bodyDict["weight"] = weight
                bodyDict["height"] = height
                bodyDict["activity_level"] = activity_level
                bodyDict["goal"] = goal
                bodyDict["gender"] = gender
                bodyDict["per_day_cal_burn"] = per_day_cal_burn
                bodyDict["goal_note"] = goal_note
//                bodyDict["zipcode"] = zipcode
                break
        case let .updateCustomerRecommendedMacros(meals_per_day: meals_per_day, snacks: snacks):
                bodyDict["card_unique_code"] = UserDefaults.standard.string(forKey: UserConstants.userCardUniqueCode)
                bodyDict["action"] = "UpdateMacros"
                bodyDict["meals_per_day"] = meals_per_day
                bodyDict["snacks"] = snacks
        case let .updateDietaryPreferences(dietary_preference: dietary_preference, diet_note: diet_note):
                bodyDict["card_unique_code"] = UserDefaults.standard.string(forKey: UserConstants.userCardUniqueCode)
                bodyDict["action"] = "UpdateDiet"
                bodyDict["dietary_preference"] = dietary_preference
                bodyDict["diet_note"] = diet_note
            default:
                print("no action")
        }
        
        return bodyDict
    }
    
    
    var parameters: [String: Any] {
        
        var paramDict : [String: Any] = [:]
        
        switch self {
        
//        case let .fitnessGoals(abc: abc):
//            paramDict["type"] = "Label"
//            paramDict["equalto___type"] = "Goal"
//            paramDict["show_columns"] = "string1"
//            break
            
        case .fitnessGoals:
            paramDict["type"] = "Label"
            paramDict["equalto___type"] = "Goal"
            paramDict["show_columns"] = "string1"
            break
            
        case .getRecommendedDailyMacros:
            paramDict["type"] = "Customer"
            paramDict["sort_by"] = "-updated_at"
            paramDict["unique_codes"] = UserDefaults.standard.string(forKey: UserConstants.userCardUniqueCode)
            break
        case .getMealsMenu:
            paramDict["type"] = "Meal"
            paramDict["state"] = "Available"
            break
        default:
            break
        }
        
        return paramDict
    }
    
    
    var method: HTTPMethod {
        switch self {
        case .activityLevels, .fitnessGoals, .getRecommendedDailyMacros, .orderPlacementDetails, .getMealsMenu:
            return .get
        case .createUser, .loginUser:
            return .post
        case .updateCustomerBasicDetails, .updateCustomerRecommendedMacros, .updateDietaryPreferences:
            return .patch
        }
    }
    
    
    var headers: HTTPHeaders {
        
        var headers : [String:String] = [:]
        
        switch self {
            case .createUser, .loginUser:
                  headers[UserConstants.content_type] = "application/json"
            case .updateCustomerBasicDetails, .updateCustomerRecommendedMacros, .updateDietaryPreferences:
                  headers[UserConstants.content_type] = "application/json"
                  headers[UserConstants.authentication] = "Bearer \(UserDefaults.standard.string(forKey: UserConstants.userToken)!)"
            case .fitnessGoals, .getRecommendedDailyMacros, .getMealsMenu:
                  headers[UserConstants.authentication] = "Bearer \(UserDefaults.standard.string(forKey: UserConstants.userToken)!)"
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
