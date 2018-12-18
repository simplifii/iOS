//
//  JsonParser.swift
//  BrewBound
//
//  Created by Nitin Bansal on 20/05/17.
//  Copyright © 2017 Nitin Bansal. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
class JsonParser: NSObject {
    
    static func parseJson(taskCode:TASKCODES, response : DataResponse<String>)->AnyObject{
        switch taskCode {
        case .GET_COURSES_AND_CHALLENGES:
            return CoursesAndChallengesApiResponse(JSONString : response.result.value!)!
//        case .GET_COUNTRIES_LIST:
//            return CountryListApiResponse(JSONString : response.result.value!)!
//        case .GET_NETWORK_SEARCH_RESULT:
//            return NetworkUserListApiResponse(JSONString : response.result.value!)!
//        case .GET_SPEAKERS:
//            return SpeakerListApiResponse(JSONString : response.result.value!)!
//        case .GET_TICKET_NUMBER:
//            return TicketApiResponse(JSONString : response.result.value!)!
//        case .POST_USER_REGISTRATION,
//             .POST_USER_SIGN_IN,
//             .GET_USER_PROFILE,
//             .PUT_USER_PROFLE,
//             .PUT_USER_PASSWORD:
//            return UserApiResponse(JSONString : response.result.value!)!
//        case .GET_SPONSOR:
//            return SponsorApiResponse(JSONString : response.result.value!)!
//        case .GET_EVENT_DAYS:
//            return AgendaListApiResponse(JSONString : response.result.value!)!
//        case .GET_YEARS_IN_REVIEW:
//            return YearsInReviewListApiResponse(JSONString : response.result.value!)!
//        case .GET_NOTIFICATION_LIST:
//            return NotificationListApiResponse(JSONString : response.result.value!)!
        default:
            break;
        }
        return BaseResponse(JSONString : response.result.value!)!
    }
    
    
}


