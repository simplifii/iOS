//
//  DateUtil.swift
//  Reach-Swift
//
//  Created by akash savediya on 14/08/17.
//  Copyright © 2017 Kartik. All rights reserved.
//

import UIKit

class DateUtil: NSObject {

    static let UI_TIME_FORMAT = "HH:mm";
    static let UI_DATE_FORMAT = "dd/MM/yyyy";
    static let UI_DATE_FORMAT_EXPERT_PROFILE = "dd-MM-yyyy";
    static let UI_DATE_TIME_FORMAT = "dd-MM-yyyy HH:mm";
    static let UI_12HR_DATE_TIME_FORMAT = "dd-MM-yyyy hh:mm a";
    static let UI_DATE_TIME_FORMAT_SEC = "dd-MM-yyyy HH:mm:ss";
    static let UI_YEAR_FORMAT = "yyyy";
    
    static func convertTimeToDateString(timeInMillis : Int64, convertFormat : String)->String{
        let timeInSec = timeInMillis/1000;
        let date = Date.init(timeIntervalSince1970: TimeInterval(timeInSec));
        let dateFormatter = DateFormatter()
        //Set timezone that you want
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = convertFormat //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate;
    }
    
    static func convertStringToDate(_ dateString : String, reqDateFormat : String)->Date{
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = reqDateFormat
        let dayDate = dateFormater.date(from: dateString);
        return dayDate!
    }
    
    static func changeDateFormat(_ serverDateString : String, _ serverDateFormat: String, _ reqDateFormat : String)->String{
        let dateFormater = DateFormatter()
        dateFormater.timeZone = TimeZone(abbreviation: "UTC")
        dateFormater.dateFormat = serverDateFormat
        let dayDate = dateFormater.date(from: serverDateString);
        dateFormater.timeZone = TimeZone.current
//        dateFormater.locale = NSLocale.current
        dateFormater.dateFormat = reqDateFormat;
        return dateFormater.string(from: dayDate!)
    }
    
    static func calculateDays(_ from: Date)->Int{
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let now: NSDate! = NSDate()
        let calcDays = calendar.components(.day, from: from, to: now as Date, options: [])
        let numberOfDays = calcDays.day
        return numberOfDays!
    }
    
    static func getStartDateForFilter()->Date{
        return convertStringToDate("01-01-2017", reqDateFormat: "dd-MM-yyyy")
    }
    
    static func calculateDaysFromFilterStartDate() -> Int {
        let startDate = getStartDateForFilter();
        return calculateDays(startDate);
    }
    
    static func getDateAfterAddingDays(_ days : Int, startDate : Date)->Date{
         let date = Calendar.current.date(byAdding: .day, value: days, to: startDate)
        return date!;
    }
    
    static func getDate(_ minSelectedValue : Double)->String{
        let displayDate = getDateValue(minSelectedValue)
        return DateUtil.convertTimeToDateString(timeInMillis: Int64(displayDate.timeIntervalSince1970*1000), convertFormat: DateUtil.UI_DATE_FORMAT)
    }
    
    static func getDateValue(_ minSelectedValue : Double)->Date{
        let startDate = DateUtil.getStartDateForFilter();
        let daysCount = Int(minSelectedValue);
        let displayDate = DateUtil.getDateAfterAddingDays(daysCount, startDate: startDate)
        return displayDate;
    }
    
    static func isBetweenSelectedDateRange(_ minValue : Double, maxValue : Double, createdServerTime : Int64)->Bool{
        let minDate : Date = getDateValue(minValue)
        let maxDate : Date = getDateValue(maxValue)
        let minTimeStamp = Int64(minDate.timeIntervalSince1970)*1000
        let maxTimeStamp = Int64(maxDate.timeIntervalSince1970)*1000
        return createdServerTime >= minTimeStamp && createdServerTime <= maxTimeStamp;
    }
    
    static func minutesToMilisConversion(minute: Int)-> Int64{
        let milis = minute*60*1000
        return Int64(milis)
    }
}
