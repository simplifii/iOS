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

    // Login
    
    static func loginUser(username: String, password: String, completion: @escaping (Bool, String) -> Void){
        if !Connectivity.isConnectedToInternet {
            completion(false, "Unable to connect to internet")
        }
        
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
    
    // GET
    
    static func activityLevels(completion: @escaping (Bool, String, JSON) -> Void){
        sendRequestAndGetData(request: APIRouter.activityLevels(), completion: {success,msg,json_data in
            completion(success, msg, json_data)
        })
    }
    
    static func fitnessGoals(completion: @escaping (Bool, String, JSON) -> Void){
        sendRequestAndGetData(request: APIRouter.fitnessGoals(), completion: {success,msg,json_data in
            completion(success, msg, json_data)
        })
    }
    
    static func getRecommendedDailyMacros(completion: @escaping (Bool, String, JSON) -> Void){
        sendRequestAndGetData(request: APIRouter.getUserProfile(), completion: {success,msg,json_data in
            completion(success, msg, json_data)
        })
    }
    
    static func getUserProfile(completion: @escaping (Bool, String, JSON) -> Void){
        sendRequestAndGetData(request: APIRouter.getUserProfile(), completion: {success,msg,json_data in
            completion(success, msg, json_data)
        })
    }
    
    static func getUserAddress(completion: @escaping (Bool, String, JSON) -> Void){
        sendRequestAndGetData(request: APIRouter.getUserProfile(), completion: {success,msg,json_data in
            completion(success, msg, json_data)
        })
    }
    
    static func getOrderPlacementDetails(completion: @escaping (Bool, String, JSON) -> Void){
        sendRequestAndGetData(request: APIRouter.orderPlacementDetails(), completion: {success,msg,json_data in
            completion(success, msg, json_data)
        })
    }
    
    static func getMealsMenu(completion: @escaping (Bool, String, JSON) -> Void){
        sendRequestAndGetData(request: APIRouter.getMealsMenu(), completion: {success,msg,json_data in
            completion(success, msg, json_data)
        })
    }
    
    static func getZipcodeServiceabilityInfo(zipcode: String, completion: @escaping (Bool, String, JSON) -> Void){
        sendRequestAndGetData(request: APIRouter.getZipcodeServiceabilityInfo(zipcode: zipcode), completion: {success,msg,json_data in
            completion(success, msg, json_data)
        })
    }
    
    static func getDeliveryDate(completion: @escaping (Bool, String, JSON) -> Void){
        sendRequestAndGetData(request: APIRouter.getDeliveryDate(), completion: {success,msg,json_data in
            completion(success, msg, json_data)
        })
    }
    
    static func getRecipeTags(completion: @escaping (Bool, String, JSON) -> Void){
        sendRequestAndGetData(request: APIRouter.getRecipeTags(), completion: {success,msg,json_data in
            completion(success, msg, json_data)
        })
    }
    
    static func getUserFavouriteRecipes(completion: @escaping (Bool, String, JSON) -> Void){
        sendRequestAndGetData(request: APIRouter.getUserFavouriteRecipes(), completion: {success,msg,json_data in
            completion(success, msg, json_data[0]["Recipe"])
        })
    }
    
    static func getRecipesList(recipeTag:String, completion: @escaping (Bool, String, JSON) -> Void){
        sendRequestAndGetData(request: APIRouter.getRecipesList(recipeTag: recipeTag), completion: {success,msg,json_data in
            completion(success, msg, json_data)
        })
    }
    
    
    // POST & PATCH
    
    static func updateCustomerBasicDetails(age: String, weight: String, height: String, activity_level: String?, goal: String, gender: String, per_day_cal_burn: String, goal_note: String?, completion: @escaping (Bool, String) -> Void) {
        
        let request = APIRouter.updateCustomerBasicDetails(age: age, weight: weight, height: height, activity_level: activity_level, goal: goal, gender: gender, per_day_cal_burn: per_day_cal_burn, goal_note: goal_note)
        
        sendRequest(request: request, completion: {success,msg in
            completion(success, msg)
        })
    }
    
    static func updateCustomerRecommendedMacros(meals_per_day: String, snacks: String, completion: @escaping (Bool, String) -> Void) {
        let request = APIRouter.updateCustomerRecommendedMacros(meals_per_day: meals_per_day, snacks: snacks)
        
        sendRequest(request: request, completion: {success,msg in
                completion(success, msg)
        })
    }
    
    static func updateDietaryPreferences(dietary_preference: String, diet_note: String?, completion: @escaping (Bool, String) -> Void) {
        let request = APIRouter.updateDietaryPreferences(dietary_preference: dietary_preference, diet_note: diet_note)
        
        sendRequest(request: request, completion: {success,msg in
            completion(success, msg)
        })
    }
    
    static func markRecipeAsFavourite(cardUniqueCode:String, completion: @escaping (Bool, String) -> Void) {
        let request = APIRouter.markRecipeAsFavourite(cardUniqueCode: cardUniqueCode)
        
        sendRequest(request: request, completion: {success,msg in
            completion(success, msg)
        })
    }
    
    static func placeNewOrder(addressLineOne: String, addressLineTwo: String?, note: String?, deliverySlot: String, zipcode:String, deliveryDateFrom:String, deliveryDateTo:String, meals:[[String:Any]], completion: @escaping (Bool, String, JSON)->Void) {
        let request = APIRouter.placeNewOrder(addressLineOne: addressLineOne, addressLineTwo: addressLineTwo, note: note, deliverySlot: deliverySlot, zipcode:zipcode, deliveryDateFrom:deliveryDateFrom, deliveryDateTo:deliveryDateTo, meals:meals)
        
        sendRequestAndGetData(request: request, completion: {success,msg,data in
            completion(success, msg, data)
        })
        
    }
    
    static func orderPayment(stripeToken: String, amount: Int, orderId: String, orderCardUniqueCode: String, credits: Int, completion: @escaping (Bool, String) -> Void) {
        let request = APIRouter.orderPayment(stripeToken: stripeToken, amount: amount, orderId: orderId, orderCardUniqueCode: orderCardUniqueCode, credits: credits)
        
        sendRequest(request: request, completion: {success,msg in
            completion(success, msg)
        })
    }
    
    
    static func sendRequest(request: URLRequestConvertible, completion: @escaping (Bool, String) -> Void) {
        if !Connectivity.isConnectedToInternet {
            completion(false, "Unable to connect to internet")
            return
        }
        
        Alamofire.request(request)
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
    
    static func sendRequestAndGetData(request: URLRequestConvertible, completion: @escaping (Bool, String, JSON) -> Void) {
        if !Connectivity.isConnectedToInternet {
            completion(false, "Unable to connect to internet", [])
            return
        }
        
        Alamofire.request(request)
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
    
}
