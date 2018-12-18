//
//  ValidationUtil.swift
//  DISC
//
//  Created by mac on 11/22/18.
//  Copyright © 2018 DISC. All rights reserved.
//

import Foundation
import UIKit

class ValidationUtil{
    
    static let EMAIL_REGEX = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
    static let MIN_LENGTH_PASSWORD = 4;
    static let NUMBER_REGEX = "^\\s*(?:\\+?(\\d{1,3}))?[-. (]*(\\d{3})[-. )]*(\\d{3})[-. ]*(\\d{4})(?: *x(\\d+))?\\s*$"
    
    static func isEmailValid(_ email:String)-> Bool{
        if (!email.isEmpty) {
            let regex = try! NSRegularExpression(pattern: EMAIL_REGEX,options: [])
            return regex.matches(email)
        }
        return false;
    }
    
    static func isEmailNotValid(_ email:String) -> Bool{
        return !isEmailValid(email);
    }
    
    static func isPasswordValid(_ password:String) ->Bool {
        return isNotEmpty(password) && (password.count >= MIN_LENGTH_PASSWORD);
    }
    
    static func isPasswordNotValid(_ password:String) -> Bool{
        return !isPasswordValid(password);
    }
    
    static func isNumberValid(_ number:String) -> Bool{
        if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: number)){
            return number.count>=9 && number.count<=14
        }
        return false
    }
    
    static func isNumberNotValid(_ number:String) -> Bool{
        return !isNumberValid(number)
    }
    
    static func isCountryCodeValid(_ countryCode:String) -> Bool{
        if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: countryCode)){
            return countryCode.count>=0 && countryCode.count<=4
        }
        return false
    }
    
    static func isCountryCodeNotValid(_ countryCode:String) -> Bool{
        return !isCountryCodeValid(countryCode)
    }
    
    static func isEmpty(_ textField:UITextField) -> Bool{
        return textField.text!.isEmpty
    }
    
    static func isNotEmpty(_ textField:UITextField) -> Bool{
        return !isEmpty(textField)
    }
    
    static func isEmpty(_ field:String) -> Bool{
        return field.isEmpty;
    }
    
    static func isNotEmpty(_ field:String) -> Bool{
        return !isEmpty(field);
    }
    
    static func isEquals(_ fieldA:String, _ fieldB:String, ignoreCase:Bool) -> Bool{
        return ignoreCase ? fieldA.lowercased() == fieldB.lowercased() : fieldA == fieldB;
    }
    
    static func isNotEquals(_ fieldA:String, _ fieldB:String, ignoreCase:Bool) -> Bool{
        return !isEquals(fieldA, fieldB, ignoreCase: ignoreCase);
    }
    
}

