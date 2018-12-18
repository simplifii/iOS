//
//  ApiGenerator.swift
//  BrewBound
//
//  Created by Nitin Bansal on 20/05/17.
//  Copyright © 2017 Nitin Bansal. All rights reserved.
//

import UIKit

class ApiGenerator: NSObject {
    
    
    
    
    static func getCoursesAndChallenges()->HttpObject{
        let httpRequest : HttpObject = HttpObject();
        httpRequest.methodType = METHODS.GET;
        httpRequest.strUrl = NetworkingConstants.GET_COURSES_AND_CHALLENGES;
        httpRequest.strtaskCode = TASKCODES.GET_COURSES_AND_CHALLENGES;
        httpRequest.addAuthHeader()
        httpRequest.addHeader("Content-Type", value: "application/json")
        httpRequest.addHeader("Postman-Token",value: "9b72c852-967a-4794-afd0-a9fdbb6619c8")
        httpRequest.addHeader("cache-control",value: "no-cache")
        
        return httpRequest
    }
//
//    static func getCountryList()->HttpObject{
//        let httpRequest : HttpObject = HttpObject();
//        httpRequest.methodType = METHODS.GET;
//        httpRequest.strUrl = WEB_SERVICE.GET_COUNTRIES_LIST;
//        httpRequest.strtaskCode = TASKCODES.GET_COUNTRIES_LIST;
//        httpRequest.addAuthHeader()
//        return httpRequest
//    }
//    
//    static func uploadFileRequest(_ fileRequest : FileRequest)->HttpObject{
//        let req = HttpObject.init()
//        req.strUrl = WEB_SERVICE.FILE_UPLOAD
//        req.strtaskCode = TASKCODES.FILE_UPLOAD
//        req.methodType = METHODS.FILE_UPLOAD
//        req.fileRequest = fileRequest;
//        req.addHeader("Accept", value: "application/json")
//        return req;
//    }
//    
//    static func getNetworkSearchResult(name:String,designation:String,country:String,organisation:String)->HttpObject{
//        let httpRequest : HttpObject = HttpObject();
//        httpRequest.methodType = METHODS.GET;
//        httpRequest.strUrl = WEB_SERVICE.GET_NETWORK_SEARCH_RESULT;
//        httpRequest.strtaskCode = TASKCODES.GET_NETWORK_SEARCH_RESULT;
//        
//        if !name.isEmpty{
//            httpRequest.addParam("name", andValue: name)
//            print("name")
//        }
//        
//        if !designation.isEmpty{
//            httpRequest.addParam("designation", andValue: designation)
//            print("designation")
//        }
//        
//        if !country.isEmpty{
//            httpRequest.addParam("country", andValue: country)
//            print("country")
//        }
//        
//        if !organisation.isEmpty{
//            httpRequest.addParam("organization", andValue: organisation)
//            print(organisation)
//        }
//        httpRequest.addAuthHeader()
//        return httpRequest
//    }
//    
//    static func getSpeakerList()->HttpObject{
//        let httpRequest : HttpObject = HttpObject();
//        httpRequest.methodType = METHODS.GET;
//        httpRequest.strUrl = WEB_SERVICE.GET_SPEAKERS;
//        httpRequest.strtaskCode = TASKCODES.GET_SPEAKERS;
//        httpRequest.addAuthHeader()
//        return httpRequest
//    }
//    
//    static func getTicketStatus(ticketNumber:String)->HttpObject{
//        let httpRequest : HttpObject = HttpObject();
//        httpRequest.methodType = METHODS.GET;
//        httpRequest.strUrl = WEB_SERVICE.GET_TICKET_NUMBER;
//        httpRequest.strtaskCode = TASKCODES.GET_TICKET_NUMBER;
//        
//        httpRequest.addParam("ticketNumber", andValue: ticketNumber)
//        httpRequest.addAuthHeader()
//        return httpRequest
//    }
//    
//    static func postUserRegistration(userModel:UserModel)->HttpObject{
//        let httpRequest : HttpObject = HttpObject();
//        httpRequest.methodType = METHODS.POST;
//        httpRequest.strUrl = WEB_SERVICE.POST_USER_REGISTRATION;
//        httpRequest.strtaskCode = TASKCODES.POST_USER_REGISTRATION;
//        
//        httpRequest.addParam("firstName",andValue: userModel.firstName ?? "")
//        httpRequest.addParam("middleName",andValue: userModel.middleName ?? "")
//        httpRequest.addParam("lastName",andValue: userModel.lastName ?? "")
//        httpRequest.addParam("gender",andValue: userModel.gender.uppercased() )
//        httpRequest.addParam("Designation",andValue: userModel.designation ?? "")
//        httpRequest.addParam("Organization",andValue: userModel.organization ?? "")
//        httpRequest.addParam("MobileNumberPrecode",andValue: userModel.homeCountryCode ?? "")
//        httpRequest.addParam("MobileNumber",andValue: userModel.homeNumber ?? "")
//        httpRequest.addParam("WokPhoneNumberPreCode",andValue: userModel.workCountryCode ?? "")
//        httpRequest.addParam("WorkPhoneNumber",andValue: userModel.workNumber ?? "")
//        httpRequest.addParam("WorkPhoneNumberExtension",andValue: userModel.workExtension ?? "")
//        httpRequest.addParam("email",andValue: userModel.email)
//        if userModel.password != nil{
//            httpRequest.addParam("password",andValue: userModel.password)
//        }
//        
//        httpRequest.addParam("TicketNumber",andValue: userModel.ticketNumber ?? "")
//        httpRequest.addParam("City",andValue: userModel.city ?? "")
//        httpRequest.addParam("Country",andValue: userModel.country ?? "")
//        httpRequest.addParam("ProfilePicLink",andValue: userModel.profilePicLink ?? "")
//        httpRequest.addParam("WebsiteLink",andValue: userModel.websiteLink ?? "")
//        httpRequest.addParam("FacebookLink",andValue: userModel.facebookLink ?? "")
//        httpRequest.addParam("LinkedInLink",andValue: userModel.linkedInLink ?? "")
//        httpRequest.addParam("TwitterLink",andValue: userModel.twitterLink ?? "")
//        httpRequest.addParam("AdditionalLink",andValue: userModel.additionalLink ?? "")
//        httpRequest.addParam("About",andValue: userModel.about ?? "")
//        httpRequest.addParam("consentForNetworking",andValue: userModel.consentForNetworking)
//        httpRequest.setPostMethod();
//        return httpRequest
//    }
//    
//    static func postUserLogin(email:String,password:String)->HttpObject{
//        let httpRequest : HttpObject = HttpObject();
//        httpRequest.methodType = METHODS.POST;
//        httpRequest.strUrl = WEB_SERVICE.POST_USER_SIGN_IN;
//        httpRequest.strtaskCode = TASKCODES.POST_USER_SIGN_IN;
//        httpRequest.addParam("email",andValue: email)
//        httpRequest.addParam("password",andValue: password)
//        httpRequest.setPostMethod();
//        return httpRequest
//    }
//    
//    static func getUser()->HttpObject{
//        let httpRequest : HttpObject = HttpObject();
//        httpRequest.methodType = METHODS.GET;
//        httpRequest.strUrl = WEB_SERVICE.GET_USER_PROFILE + DefaultsUtil.getId();
//        httpRequest.strtaskCode = TASKCODES.GET_USER_PROFILE;        
//        httpRequest.addAuthHeader()
//        return httpRequest
//    }
//    
//    static func putUser(userModel:UserModel)->HttpObject{
//        let httpRequest : HttpObject = HttpObject();
//        httpRequest.methodType = METHODS.PUT;
//        httpRequest.strUrl = WEB_SERVICE.PUT_USER_PROFLE + DefaultsUtil.getId();
//        httpRequest.strtaskCode = TASKCODES.PUT_USER_PROFLE;
//        
//        httpRequest.addParam("firstName",andValue: userModel.firstName ?? "")
//        httpRequest.addParam("middleName",andValue: userModel.middleName ?? "")
//        httpRequest.addParam("lastName",andValue: userModel.lastName ?? "")
//        httpRequest.addParam("gender",andValue: userModel.gender.uppercased() )
//        httpRequest.addParam("Designation",andValue: userModel.designation ?? "")
//        httpRequest.addParam("Organization",andValue: userModel.organization ?? "")
//        httpRequest.addParam("MobileNumberPrecode",andValue: userModel.homeCountryCode ?? "")
//        httpRequest.addParam("MobileNumber",andValue: userModel.homeNumber ?? "")
//        httpRequest.addParam("WokPhoneNumberPreCode",andValue: userModel.workCountryCode ?? "")
//        httpRequest.addParam("WorkPhoneNumber",andValue: userModel.workNumber ?? "")
//        httpRequest.addParam("WorkPhoneNumberExtension",andValue: userModel.workExtension ?? "")
//        httpRequest.addParam("email",andValue: userModel.email)
//        if userModel.password != nil{
//            httpRequest.addParam("password",andValue: userModel.password)
//        }
//        httpRequest.addParam("TicketNumber",andValue: userModel.ticketNumber ?? "")
//        httpRequest.addParam("City",andValue: userModel.city ?? "")
//        httpRequest.addParam("Country",andValue: userModel.country ?? "")
//        httpRequest.addParam("ProfilePicLink",andValue: userModel.profilePicLink ?? "")
//        httpRequest.addParam("WebsiteLink",andValue: userModel.websiteLink ?? "")
//        httpRequest.addParam("FacebookLink",andValue: userModel.facebookLink ?? "")
//        httpRequest.addParam("LinkedInLink",andValue: userModel.linkedInLink ?? "")
//        httpRequest.addParam("TwitterLink",andValue: userModel.twitterLink ?? "")
//        httpRequest.addParam("AdditionalLink",andValue: userModel.additionalLink ?? "")
//        httpRequest.addParam("About",andValue: userModel.about ?? "")
//        httpRequest.addParam("consentForNetworking",andValue: userModel.consentForNetworking ?? false)
//        httpRequest.setPutMethod()
//        return httpRequest
//    }
//    
//    static func getSponsorList()->HttpObject{
//        let httpRequest : HttpObject = HttpObject();
//        httpRequest.methodType = METHODS.GET;
//        httpRequest.strUrl = WEB_SERVICE.GET_SPONSOR;
//        httpRequest.strtaskCode = TASKCODES.GET_SPONSOR;
//        httpRequest.addAuthHeader()
//        return httpRequest
//    }
//    
//    static func getAgendaList()->HttpObject{
//        let httpRequest : HttpObject = HttpObject();
//        httpRequest.methodType = METHODS.GET;
//        httpRequest.strUrl = WEB_SERVICE.GET_EVENT_DAYS;
//        httpRequest.strtaskCode = TASKCODES.GET_EVENT_DAYS;
//        httpRequest.addParam("eventId", andValue: 16)
//        httpRequest.addAuthHeader()
//        return httpRequest
//    }
//    
//    static func getYearsInReviewList()->HttpObject{
//        let httpRequest : HttpObject = HttpObject();
//        httpRequest.methodType = METHODS.GET;
//        httpRequest.strUrl = WEB_SERVICE.GET_YEARS_IN_REVIEW;
//        httpRequest.strtaskCode = TASKCODES.GET_YEARS_IN_REVIEW;
//        httpRequest.addAuthHeader()
//        return httpRequest
//    }
//    
//    static func getNotificationList()->HttpObject{
//        let httpRequest : HttpObject = HttpObject();
//        httpRequest.methodType = METHODS.GET;
//        httpRequest.strUrl = WEB_SERVICE.GET_NOTIFICATION_LIST;
//        httpRequest.strtaskCode = TASKCODES.GET_NOTIFICATION_LIST;
//        httpRequest.addAuthHeader()
//        return httpRequest
//    }
//    
//    static func postForgetPassword(email:String)->HttpObject{
//        let httpRequest : HttpObject = HttpObject();
//        httpRequest.methodType = METHODS.POST;
//        httpRequest.strUrl = WEB_SERVICE.POST_USER_FORGET_PASSWORD;
//        httpRequest.strtaskCode = TASKCODES.POST_USER_FORGET_PASSWORD;
//        httpRequest.addParam("email", andValue: email)
//        httpRequest.setPostMethod()
//        return httpRequest
//    }
//    
//    static func putUserPassword(password:String)->HttpObject{
//        let httpRequest : HttpObject = HttpObject();
//        httpRequest.methodType = METHODS.PUT;
//        httpRequest.strUrl = WEB_SERVICE.PUT_USER_PROFLE + DefaultsUtil.getId();
//        httpRequest.strtaskCode = TASKCODES.PUT_USER_PASSWORD;
//        httpRequest.addParam("password",andValue: password)
//        httpRequest.setPutMethod()
//        return httpRequest
//    }
}
