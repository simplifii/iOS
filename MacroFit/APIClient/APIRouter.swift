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
    case getUserProfile()
    case updateDietaryPreferences(dietary_preference: String, diet_note: String?)
    case orderPlacementDetails()
    case getMealsMenu()
    case placeNewOrder(addressLineOne: String, addressLineTwo: String?, note: String?, deliverySlot: String, zipcode:String, deliveryDateFrom:String, deliveryDateTo:String, meals:[[String:Any]])
    case getZipcodeServiceabilityInfo(zipcode: String)
    case orderPayment(stripeToken: String, amount: Int, orderId: String, orderCardUniqueCode: String, credits: Int)
    case getDeliveryDate()
    case getRecipeTags()
    case getUserFavouriteRecipes()
    case getRecipesList(recipeTag: String)
    case markRecipeAsFavourite(cardUniqueCode:String)
    case logoutUser()
    case getUserRecipes(recipeTag: String?)
    case userInterestInFitness(action: String?)
    case unfavouriteRecipe(cardUniqueCode:String, recipeId: Int)
    case createFeedback(rating: Int)
    case editFeedback(uniqueCode: String, feedback: String)
    case getFeedback()
    case updateBodyFat(bodyFat:Int)
    case updateAddress(addressLineOne: String, addressLineTwo:String?, zipcode:String)
    
    var path: String {
        
        switch self {
            case .getUserRecipes:
                return NetworkingConstants.userRecipes
            case .activityLevels:
                return NetworkingConstants.activityLevels
            
            case .loginUser:
                return NetworkingConstants.login
            
            case .createUser, .updateCustomerBasicDetails, .updateCustomerRecommendedMacros, .getUserProfile, .updateDietaryPreferences, .updateBodyFat, .updateAddress:
                return NetworkingConstants.users
            
            case .fitnessGoals:
                return NetworkingConstants.fitnessGoals
            case .orderPlacementDetails:
                return NetworkingConstants.orderPlacementDetails
            case .getMealsMenu:
                return NetworkingConstants.meals
            case .placeNewOrder:
                return NetworkingConstants.orders
            case .getZipcodeServiceabilityInfo:
                return NetworkingConstants.cards
            case .orderPayment:
                return NetworkingConstants.payment
            case .getDeliveryDate:
                return NetworkingConstants.deliveryDate
            case .getRecipeTags:
                return NetworkingConstants.cards
            case .getUserFavouriteRecipes, .unfavouriteRecipe:
                return NetworkingConstants.cards
            case .getRecipesList, .markRecipeAsFavourite:
                return NetworkingConstants.cards
            case .logoutUser:
                return NetworkingConstants.logout
            case .userInterestInFitness:
                return NetworkingConstants.cards
            case .createFeedback, .editFeedback, .getFeedback:
                return NetworkingConstants.cards
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
                break
        case let .updateDietaryPreferences(dietary_preference: dietary_preference, diet_note: diet_note):
                bodyDict["card_unique_code"] = UserDefaults.standard.string(forKey: UserConstants.userCardUniqueCode)
                bodyDict["action"] = "UpdateDiet"
                bodyDict["dietary_preference"] = dietary_preference
                bodyDict["diet_note"] = diet_note
                break
        case let .placeNewOrder(addressLineOne: addressLineOne, addressLineTwo: addressLineTwo, note: note, deliverySlot: deliverySlot, zipcode:zipcode, deliveryDateFrom:deliveryDateFrom, deliveryDateTo:deliveryDateTo, meals:meals):
                bodyDict["entity"] = "Order"
                bodyDict["action"] = "Create"
                bodyDict["address_line_1"] = addressLineOne
                bodyDict["address_line_2"] = addressLineTwo
                bodyDict["note"] = note
                bodyDict["delivery_slot"] = deliverySlot
                bodyDict["zipcode"] = zipcode
                bodyDict["meals"] = meals
                bodyDict["delivery_window_starttime"] = deliveryDateFrom
                bodyDict["delivery_window_endtime"] = deliveryDateTo
                break
        case let .orderPayment(stripeToken: stripeToken, amount: amount, orderId: orderId, orderCardUniqueCode: orderCardUniqueCode, credits: credits):
                bodyDict["stripeToken"] = stripeToken
                bodyDict["amount"] = amount
                bodyDict["order_id"] = orderId
                bodyDict["order_card_uniquecode"] = orderCardUniqueCode
                bodyDict["credits_tobe_used"] = credits
                break
        case let .markRecipeAsFavourite(cardUniqueCode:cardUniqueCode):
                bodyDict["action"] = "PinRecipe"
                bodyDict["card_unique_code"] = cardUniqueCode
                break
        case let .unfavouriteRecipe(cardUniqueCode:cardUniqueCode, recipeId: recipeId):
            bodyDict["action"] = "UnpinRecipe"
            bodyDict["card_unique_code"] = cardUniqueCode
            bodyDict["recipe"] = recipeId
            break
        case let .userInterestInFitness(action: action):
            bodyDict["action"] = action
            bodyDict["card_unique_code"] = "EDBA7BAA57"
            bodyDict["count"] = 1
        case let .createFeedback(rating: rating):
            bodyDict["entity"] = "Feedback"
            bodyDict["action"] = "Create"
            bodyDict["rating"] = rating
            bodyDict["type"] = "AppRating"
        case let .editFeedback(uniqueCode: uniqueCode,feedback: feedback):
            bodyDict["action"] = "Update"
            bodyDict["card_unique_code"] = uniqueCode
            bodyDict["feedback"] = feedback
        case let .updateBodyFat(bodyFat: bodyFat):
            bodyDict["card_unique_code"] = UserDefaults.standard.string(forKey: UserConstants.userCardUniqueCode)
            bodyDict["action"] = "UpdateBodyFat"
            bodyDict["body_fat"] = bodyFat
            break
        case let .updateAddress(addressLineOne: addressLineOne, addressLineTwo:addressLineTwo, zipcode:zipcode):
            bodyDict["card_unique_code"] = UserDefaults.standard.string(forKey: UserConstants.userCardUniqueCode)
            bodyDict["action"] = "UpdateAddress"
            bodyDict["address_line_1"] = addressLineOne
            bodyDict["address_line_2"] = addressLineTwo
            bodyDict["zipcode"] = zipcode
            break
            default:
                print("no action")
        }
        
        return bodyDict
    }
    
    
    var parameters: [String: Any] {
        
        var paramDict : [String: Any] = [:]
        
        switch self {
        
        case .fitnessGoals:
            paramDict["type"] = "Label"
            paramDict["equalto___type"] = "Goal"
            paramDict["show_columns"] = "string1"
            break
            
        case .getUserProfile:
            paramDict["type"] = "Customer"
            paramDict["sort_by"] = "-updated_at"
            paramDict["unique_codes"] = UserDefaults.standard.string(forKey: UserConstants.userCardUniqueCode)
            break
        case .getMealsMenu:
            paramDict["type"] = "Meal"
            paramDict["state"] = "Available"
            break
        case let .getZipcodeServiceabilityInfo(zipcode: zipcode):
            paramDict["type"] = "Zipcode"
            paramDict["state"] = "Created"
            paramDict["equalto___zipcode"] = zipcode
            break
        case .getRecipeTags:
            paramDict["type"] = "Label"
            paramDict["state"] = "Created"
            paramDict["equalto___type"] = "Recipe Tag"
            break
        case .getUserFavouriteRecipes:
            paramDict["type"] = "Customer"
            paramDict["unique_codes"] = UserDefaults.standard.string(forKey: UserConstants.userCardUniqueCode)
            paramDict["embed"] = "cards"
            break
        case let .getRecipesList(recipeTag: recipeTag):
            paramDict["type"] = "Recipe"
            paramDict["sort_by"] = "-updated_at"
            paramDict["search"] = recipeTag
            break
        case let .getUserRecipes(recipeTag: recipeTag):
            paramDict["recipe_tag"] = recipeTag
            break
        case .getFeedback:
            paramDict["type"] = "Feedback"
            paramDict["equalto___type"] = "AppRating"
            break
        default:
            break
        }
        
        return paramDict
    }
    
    
    var method: HTTPMethod {
        switch self {
        case .activityLevels, .fitnessGoals, .getUserProfile, .orderPlacementDetails, .getMealsMenu, .getZipcodeServiceabilityInfo, .getDeliveryDate, .getRecipeTags, .getUserFavouriteRecipes, .getRecipesList, .getUserRecipes, .getFeedback:
            return .get
        case .createUser, .loginUser, .placeNewOrder, .orderPayment, .createFeedback:
            return .post
        case .updateCustomerBasicDetails, .updateCustomerRecommendedMacros, .updateDietaryPreferences, .markRecipeAsFavourite, .logoutUser, .userInterestInFitness, .unfavouriteRecipe, .editFeedback, .updateBodyFat, .updateAddress:
            return .patch
        }
    }
    
    
    var headers: HTTPHeaders {
        
        var headers : [String:String] = [:]
        
        switch self {
            case .createUser, .loginUser:
                  headers[UserConstants.content_type] = "application/json"
            case .updateCustomerBasicDetails, .updateCustomerRecommendedMacros, .updateDietaryPreferences, .placeNewOrder, .getZipcodeServiceabilityInfo, .orderPayment, .getRecipeTags, .markRecipeAsFavourite, .logoutUser, .userInterestInFitness, .unfavouriteRecipe, .createFeedback, .editFeedback, .updateBodyFat, .updateAddress:
                  headers[UserConstants.content_type] = "application/json"
                  headers[UserConstants.authentication] = "Bearer \(UserDefaults.standard.string(forKey: UserConstants.userToken)!)"
            case .fitnessGoals, .getUserProfile, .getMealsMenu, .getUserFavouriteRecipes, .getRecipesList, .getUserRecipes, .getFeedback:
                if let token = UserDefaults.standard.string(forKey: UserConstants.userToken) {
                    headers[UserConstants.authentication] = "Bearer \(token)"
                }
            
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
