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
    case facebookLogin(fbUserId: String, fbUserToken: String)
    case activityLevels()
    case fitnessGoals()
    case updateCustomerBasicDetails(age: String, weight: String, height: String, activity_level: String?, goal: String, gender: String, per_day_cal_burn: String, goal_note: String?)
    case updateCustomerRecommendedMacros(meals_per_day: String, snacks: String)
    case getUserProfile()
    case updateDietaryPreferences(dietary_preference: String, diet_note: String?)
    case orderPlacementDetails()
    case getMealsMenu()
    case getCourses()
    case getLessons(course: String)
    case getExercises(lesson: String)
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
    
    case getChallenges()
    case getChallengeTags()
    case getChallengeSearch(searchString: String?)
    case getChallengeScore(equalto___challenge:String?,creator:String?)
    case getEachUserBestScore(equalto___challenge:String?,userBestScore:Bool,theMoreTheBetter:Bool)
    case SubmitScore(score:String?,challenge:String)
    case updateDeviceToken(token: String)
    case changePassword(newPassword: String)
    case sendCourseFeedback(forCourse: Int, starRating: Int, feedbackText: String)
    case sendLessonFeedback(forLesson: Int, starRating: Int, feedbackText: String)
    case markLessonCompleted(_ lesson: Int)
    case updateProfilePic(url: String, thumbnailUrl:String?)
    case addContactsToUserNetwork(contacts: [[String:String]])
    
    var path: String {
        
        switch self {
            case .getUserRecipes:
                return NetworkingConstants.userRecipes
            case .activityLevels:
                return NetworkingConstants.activityLevels
            
            case .loginUser:
                return NetworkingConstants.login
            
            case .facebookLogin:
                return NetworkingConstants.facebookLogin
        case .createUser, .updateCustomerBasicDetails, .updateCustomerRecommendedMacros, .getUserProfile, .updateDietaryPreferences, .updateBodyFat, .updateAddress, .updateDeviceToken, .changePassword, .updateProfilePic:
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
            case.getChallenges, .getChallengeTags, .getChallengeSearch, .getChallengeScore, .getEachUserBestScore, .SubmitScore:
                return NetworkingConstants.challenges
            case .getCourses:
                return NetworkingConstants.courses
            case .getLessons:
                return NetworkingConstants.lessons
            case .getExercises:
                return NetworkingConstants.exercises
            case .sendCourseFeedback:
                return NetworkingConstants.courseFeedback
            case .sendLessonFeedback:
                return NetworkingConstants.lessonFeedback
            case .markLessonCompleted:
                return NetworkingConstants.lessonCompleted
            case .addContactsToUserNetwork:
                return NetworkingConstants.userNetwork
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
                bodyDict["device_token"] = UserDefaults.standard.string(forKey: UserConstants.deviceToken)
                break
        case let .facebookLogin(fbUserId: fbUserId, fbUserToken: fbUserToken):
                bodyDict["fb_user_id"] = fbUserId
                bodyDict["fb_token"] = fbUserToken
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
        case let .changePassword(newPassword:newPassword):
            bodyDict["card_unique_code"] = UserDefaults.standard.string(forKey: UserConstants.userCardUniqueCode)
            bodyDict["action"] = "ChangePassword"
            bodyDict["password"] = newPassword
            break
        case let .SubmitScore(score:score,challenge:challenge):
            bodyDict["entity"] = "Score"
            bodyDict["score_type"] = "Challenge"
            bodyDict["action"] = "Create"
            bodyDict["score"] = score
            bodyDict["challenge"] = challenge
            break
        case let .updateDeviceToken(token: token):
            bodyDict["card_unique_code"] = UserDefaults.standard.string(forKey: UserConstants.userCardUniqueCode)
            bodyDict["action"] = "UpdateDeviceToken"
            bodyDict["device_token"] = token
        case let .sendCourseFeedback(forCourse: course, starRating: rating, feedbackText: text):
            if text.count > 0 {
                bodyDict["feedback"] = text
            }
            bodyDict["rating"] = rating
            bodyDict["course_id"] = course
        case let .sendLessonFeedback(forLesson: lesson, starRating: rating, feedbackText: text):
            if text.count > 0 {
                bodyDict["feedback"] = text
            }
            bodyDict["rating"] = rating
            bodyDict["lesson_id"] = lesson
        case let .markLessonCompleted(_ : lesson):
            bodyDict["lesson_id"] = lesson
        case let .updateProfilePic(url: url, thumbnailUrl: thumbnailUrl):
            bodyDict["card_unique_code"] = UserDefaults.standard.string(forKey: UserConstants.userCardUniqueCode)
            bodyDict["action"] = "UpdateProfilePic"
            bodyDict["profile_pic"] = url
            bodyDict["profile_pic_thumbnail"] = thumbnailUrl
        case let .addContactsToUserNetwork(contacts: contacts):
            bodyDict["contacts"] = contacts
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
        case .getChallenges:
            paramDict["type"] = "Challenge"
            break
        case.getChallengeTags:
            paramDict["type"] = "Label"
            paramDict["equalto___type"] = "Challenge"
            paramDict["show_columns"] = "string1"
            break
        case let .getChallengeSearch(searchString: search):
            paramDict["type"] = "Challenge"
            paramDict["search"] = search
            break
        case let .getChallengeScore(equalto___challenge:equalto_challenge,creator:creator):
            paramDict["type"] = "Score"
            paramDict["equalto___challenge"] = equalto_challenge
            paramDict["creator"] = creator
            break
        case let .getEachUserBestScore(equalto___challenge:equalto_challenge,userBestScore:userBestScore, theMoreTheBetter:theMoreTheBetter):
            if userBestScore {
                paramDict["type"] = "Score"
                paramDict["equalto___challenge"] = equalto_challenge
                paramDict["creator"] = UserDefaults.standard.string(forKey: UserConstants.userId)
                
                let date = Date()
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                let minutes = calendar.component(.minute, from: date)
                let minutesTillNow = (hour*60) + minutes
                
                
                paramDict["dategreaterthanequalto___created_at_format"] = "Y-m-d"
                paramDict["dategreaterthanequalto___created_at"] = "-\(minutesTillNow) minutes"
                paramDict["datelessthanequalto___created_at"] = "now"
            }else
            {
                paramDict["type"] = "Score"
                paramDict["equalto___challenge"] = equalto_challenge
                paramDict["equalto___users_best"] = "1"
                if theMoreTheBetter {
                    paramDict["sort_by"] = "-int2"
                } else {
                    paramDict["sort_by"] = "+int2"
                }
                paramDict["embed"] = "creator"
            }
        case let .getLessons(course: course):
            paramDict["course_id"] = course
        case let .getExercises(lesson: lesson):
            paramDict["lesson_id"] = lesson
        default:
            break
        }
        
        return paramDict
    }
    
    
    var method: HTTPMethod {
        switch self {
        case .activityLevels, .fitnessGoals, .getUserProfile, .orderPlacementDetails, .getMealsMenu, .getZipcodeServiceabilityInfo, .getDeliveryDate, .getRecipeTags, .getUserFavouriteRecipes, .getRecipesList, .getUserRecipes, .getFeedback, .getChallenges,.getChallengeTags, .getChallengeSearch, .getChallengeScore, .getEachUserBestScore, .getCourses, .getLessons, .getExercises:
            return .get
        case .createUser, .loginUser, .placeNewOrder, .orderPayment, .createFeedback, .facebookLogin, .SubmitScore, .sendCourseFeedback, .sendLessonFeedback, .markLessonCompleted, .addContactsToUserNetwork:
            return .post
        case .updateCustomerBasicDetails, .updateCustomerRecommendedMacros, .updateDietaryPreferences, .markRecipeAsFavourite, .logoutUser, .userInterestInFitness, .unfavouriteRecipe, .editFeedback, .updateBodyFat, .updateAddress, .updateDeviceToken, .changePassword, .updateProfilePic:
            return .patch
        }
    }
    
    
    var headers: HTTPHeaders {
        
        var headers : [String:String] = [:]
        
        switch self {
            case .createUser, .loginUser, .facebookLogin:
                  headers[UserConstants.content_type] = "application/json"
            case .updateCustomerBasicDetails, .updateCustomerRecommendedMacros, .updateDietaryPreferences, .placeNewOrder, .getZipcodeServiceabilityInfo, .orderPayment, .getRecipeTags, .markRecipeAsFavourite, .logoutUser, .userInterestInFitness, .unfavouriteRecipe, .createFeedback, .editFeedback, .updateBodyFat, .updateAddress, .SubmitScore, .updateDeviceToken, .changePassword, .sendCourseFeedback, .sendLessonFeedback, .markLessonCompleted, .updateProfilePic, .addContactsToUserNetwork:
                  headers[UserConstants.content_type] = "application/json"
                  headers[UserConstants.authentication] = "Bearer \(UserDefaults.standard.string(forKey: UserConstants.userToken)!)"
            case .fitnessGoals, .getUserProfile, .getMealsMenu, .getUserFavouriteRecipes, .getRecipesList, .getUserRecipes, .getFeedback, .getChallenges,.getChallengeTags,.getChallengeSearch, .getChallengeScore, .getEachUserBestScore, .getCourses, .getLessons, .getExercises:
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
