//
//  EventManager.swift
//  Reach-Swift
//
//  Created by Nitin Bansal on 15/08/17.
//  Copyright © 2017 Kartik. All rights reserved.
//

import UIKit

class EventManager: NSObject {
    public static let REFRESH_ACTION = "refreshAction"
    public static let NEW_MESSAGE_ACTION = "newMessageAction"
    public static let PRODUCT_BUY_ACTION = "productBuyAction"
    //var listenerSet = [String : Set<AnyHashable>]();
    var listenerSet = [String : [RefreshListener]]();
    
    private static var sharedInstance = EventManager();
    
    static func getInstance()->EventManager{
        return sharedInstance
    }
    
    
    func add(eventName : String, delegate : RefreshListener) {
        print("Add Listener")
        if var set = listenerSet[eventName]{
            set.append(delegate)
            listenerSet.updateValue(set, forKey: eventName)
        }else{
            var set = [RefreshListener]();
            set.append(delegate)
            listenerSet.updateValue(set, forKey: eventName)
        }
        
    }
    
    func remove(eventName : String, delegate : RefreshListener){
        print("Remove Listener")
        if var set = listenerSet[eventName]{
            var index = -1;
            for i in 0..<set.count{
                let d = set[i]
                if d === delegate{
                    index = i;
                    break
                }
            }
            if index != -1{
                set.remove(at: index)
            }
            listenerSet.updateValue(set, forKey: eventName)
        }else{
        }
    }
    
    
    func sendBroadcast(eventName : String){
        if let set = listenerSet[eventName]{
            for item in set{
                let delegate = item
                print("Send Bcast")
                delegate.onEventAction!(eventName: eventName);
            }
        }
    }
    
    func sendBroadcast(eventName : String, data : Any){
        if let set = listenerSet[eventName]{
            for item in set{
                let delegate = item
                print("Send Bcast")
                delegate.onEventAction!(eventName: eventName, data : data);
            }
        }
    }
}
@objc protocol RefreshListener {
    @objc optional func onEventAction(eventName : String)
    @objc optional func onEventAction(eventName : String, data : Any)
}
