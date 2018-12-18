//
//  DeviceModelUtil.swift
//  DISC
//
//  Created by mac on 12/1/18.
//  Copyright © 2018 DISC. All rights reserved.
//

import UIKit

public extension UIDevice {
    
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad7,5", "iPad7,6":                      return "iPad 6"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
}

struct MODEL{
    static let iPhone4 = "iPhone 4"
    static let iPhone4s = "iPhone 4s"
    static let iPhone5 = "iPhone 5"
    static let iPhone5c = "iPhone 5c"
    static let iPhone5s = "iPhone 5s"
    static let iPhone6 = "iPhone 6"
    static let iPhone6Plus = "iPhone 6 Plus"
    static let iPhone6S = "iPhone 6s"
    static let iPhone6SPlus = "iPhone 6s Plus"
    static let iPhone7 = "iPhone 7"
    static let iPhone7Plus = "iPhone 7 Plus"
    static let iPhoneSE = "iPhone SE"
    static let iPhone8 = "iPhone 8"
    static let iPhone8Plus = "iPhone 8 Plus"
    static let iPhoneX = "iPhone X"
    static let iPhoneXS = "iPhone XS"
    static let iPhoneXSMax = "iPhone XS Max"
    static let iPhoneXR = "iPhone XR"
    static let simulator = "Simulator"

    struct SIMULATOR{
        static let iPhone4 = MODEL.simulator + " " + MODEL.iPhone4
        static let iPhone4s = MODEL.simulator + " " + MODEL.iPhone4s
        static let iPhone5 = MODEL.simulator + " " + MODEL.iPhone5
        static let iPhone5c = MODEL.simulator + " " + MODEL.iPhone5c
        static let iPhone5s = MODEL.simulator + " " + MODEL.iPhone5s
        static let iPhone6 = MODEL.simulator + " " + MODEL.iPhone6
        static let iPhone6Plus = MODEL.simulator + " " + MODEL.iPhone6Plus
        static let iPhone6S = MODEL.simulator + " " + MODEL.iPhone6S
        static let iPhone6SPlus = MODEL.simulator + " " + MODEL.iPhone6SPlus
        static let iPhone7 = MODEL.simulator + " " + MODEL.iPhone7
        static let iPhone7Plus = MODEL.simulator + " " + MODEL.iPhone7Plus
        static let iPhoneSE = MODEL.simulator + " " + MODEL.iPhoneSE
        static let iPhone8 = MODEL.simulator + " " + MODEL.iPhone8
        static let iPhone8Plus = MODEL.simulator + " " + MODEL.iPhone8Plus
        static let iPhoneX = MODEL.simulator + " " + MODEL.iPhoneX
        static let iPhoneXS = MODEL.simulator + " " + MODEL.iPhoneXS
        static let iPhoneXSMax = MODEL.simulator + " " + MODEL.iPhoneXSMax
        static let iPhoneXR = MODEL.simulator + " " + MODEL.iPhoneXR
    }
    
}
