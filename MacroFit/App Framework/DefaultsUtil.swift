//
//  DefaultsUtil.swift
//  Reach-Swift
//
//  Created by Bansals on 11/07/17.
//  Copyright © 2017 Kartik. All rights reserved.
//


import UIKit

class DefaultsUtil: NSObject {
    
    static var hasConsent:Bool{
        get{
            return isUserLoggedIn() ? UserDefaults.standard.bool(forKey: "hasConsent") : false
        }
        set{
            if isUserLoggedIn(){
                UserDefaults.standard.set(newValue, forKey: "hasConsent");
            }
            else{
                UserDefaults.standard.set(false, forKey: "hasConsent");
            }
        }
    }
    
    static func getAppLanguage()->String!{
        return UserDefaults.standard.string(forKey: "appLanguage") ?? (NSLocale.current.languageCode ?? "en");
    }
    
    static func setAppLanguage(_ lang:String){
        switch lang.lowercased(){
        case "ar","es","fr":
            UserDefaults.standard.set(lang.lowercased(), forKey: "appLanguage");
        default:
            UserDefaults.standard.set("en", forKey: "appLanguage");
        }
    }
    
    static func isUserLoggedIn()->Bool{
        return UserDefaults.standard.bool(forKey: "isUserLoggedIn");
    }
    
    static func setUserLoggedIn(){
        UserDefaults.standard.set(true, forKey: "isUserLoggedIn");
    }
    
    static func logoutUser(){
        UserDefaults.standard.removeObject(forKey: "randomDeviceId")
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn");
        UserDefaults.standard.removeObject(forKey: "logintoken");
    }
    
    static func removeObject(_ key : String){
        UserDefaults.standard.removeObject(forKey: key);
    }
    
    static func getRandomUserId()->String{
        //        return "5cd62011-808b-46da-ae79-c587fb4c39f7";
        return UserDefaults.standard.string(forKey: "ruid")!;
    }
    
    static func getRandomIdentifier()->String{
        if let randomString = UserDefaults.standard.string(forKey: "randomDeviceId"){
            print("randomDeviceId : \(randomString)")
            return randomString;
        }else{
            let random = randomString(12);
            saveString(data: random, key: "randomDeviceId");
            print("randomDeviceId : \(random)")
            return random;
        }
    }
    
    static func saveId(id : String){
        saveString(data: id, key: "id");
    }
    
    static func getId()->String{
        if let randomString = UserDefaults.standard.string(forKey: "id"){
            print("id : \(randomString)")
            return randomString;
        }else{
            let random = randomString(16);
            print("id : \(random)")
            saveString(data: random, key: "id");
            return random;
        }
    }
    
    static func saveString(data : String, key : String){
        UserDefaults.standard.set(data, forKey: key);
    }
    
    static func getString(key : String)->String{
        return UserDefaults.standard.string(forKey: key)!;
    }
    
    
    static func getSharedUrl(key : String)->String?{
        return UserDefaults.standard.string(forKey: key);
    }
    
    static func getSavedEventId()->String?{
        return UserDefaults.standard.string(forKey: "savedEventId");
    }
    
    static func saveEventId(eventId : String){
        UserDefaults.standard.set(eventId, forKey: "savedEventId");
    }
    
    static func saveRegisteredUserResponse(data : String){
        saveString(data: data, key: "registeredUserResponse")
    }
    static func getRegisteredUserResponseString()->String{
        return getString(key: "registeredUserResponse");
    }
    
    static func saveUserData(data : String){
        saveString(data: data, key: "userData")
    }
    static func getUserData()->String{
        if let randomString = UserDefaults.standard.string(forKey: "userData"){
            return randomString;
        }else{
            return "{}";
        }
        
    }
    
    static func getCategoryData()->String{
        if let randomString = UserDefaults.standard.string(forKey: "catgoryData"){
            return randomString;
        }else{
            return "{}";
        }
        
    }
    
    static func saveCategoryData(data : String){
        saveString(data: data, key: "catgoryData")
    }
    
    static func randomString(_ length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    static func getImageUrlForUsers(contactNumber : String, fileDesc : String)->String{
        let prefix = "https://s3-ap-southeast-1.amazonaws.com/ybus-users/\(contactNumber)_image_\(fileDesc)_540.png"
        print("Image url for user : \(prefix)")
        return prefix;
    }
    
    static func getImageUrlForSchools(schoolId : String, fileDesc : String)->String{
        let prefix = "https://s3-ap-southeast-1.amazonaws.com/ybus-schools/\(schoolId)_school_\(fileDesc)_100.png";
        print("Image url for school : \(prefix)")
        return prefix;
    }
    
    static func getUserToken() -> String {
        if let token = UserDefaults.standard.string(forKey: "logintoken"){
            return token;
        }else{
            return "";
        }
        
    }
    
    static func setUserToken(_ userToken : String){
        saveString(data: userToken, key: "logintoken")
        
    }
    
    static func saveUserId(data : Int, key : String){
        UserDefaults.standard.set(data, forKey: key);
    }
    
    static func setUserId(_ userid : Int){
        saveUserId(data: userid, key: "userid")
    }
    
    static func getUserId() -> String {
        return getString(key: "userid");
    }
    
    static func saveTabBarHeight(_ height:Float){
        UserDefaults.standard.set(height, forKey: "tabbarheight");
    }
    
    static func getTabBarHeight() -> Float{
        return UserDefaults.standard.float(forKey: "tabbarheight")
    }

    static func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
    static func gethoursandminutes(_ today:String) -> [Int] {
        let formatter  = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let myCalendar = Calendar(identifier: .gregorian)
        let date = formatter.date(from: today)
        let hours = myCalendar.component(.hour, from: date!)
        let minutes = myCalendar.component( .minute , from: date!)
        return [hours, minutes]
    }
    

    
}
