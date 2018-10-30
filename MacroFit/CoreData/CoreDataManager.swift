//
//  CoreDataManager.swift
//  MacroFit
//
//  Created by Chandresh Singh on 30/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

class CoreDataManager {
    
    static let sharedManager = CoreDataManager()
    private init() {} // Prevent clients from creating another instance.
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MacroFit")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print(nserror)
                //fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    /*Insert*/
    func insertUserProfile(json: JSON)->UserProfile? {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        var user = NSEntityDescription.insertNewObject(forEntityName: "UserProfile", into: managedContext) as! UserProfile
        
        user = setUserProfileData(user: user, json: json)
        
        do {
            try managedContext.save()
            return user
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    
    func setUserProfileData(user : UserProfile, json: JSON)->UserProfile {
        user.id = Int32(json["id"].intValue)
        user.unique_code = json["unique_code"].stringValue
        user.username = json["username"].stringValue
        user.name = json["string1"].stringValue
        user.email = json["string2"].stringValue
        user.activity_level = json["string4"].stringValue
        user.goal = json["string5"].stringValue
        user.mobile = json["string6"].stringValue
        user.full_address = json["string7"].stringValue
        user.goal_note = json["string10"].stringValue
        user.zipcode = Int32(json["int1"].intValue)
        user.calories = Int16(json["int2"].intValue)
        user.carbs = Int16(json["int3"].intValue)
        user.protein = Int16(json["int4"].intValue)
        user.fat = Int16(json["int5"].intValue)
        user.credits = Int16(json["int6"].intValue)
        user.gender_bool = json["bool1"].boolValue
        user.macros_specified = json["bool2"].boolValue
        user.recipe_subscription_valid = json["bool3"].boolValue
        user.free_recipe_subscription_awarded = json["bool4"].boolValue
        user.weight = json["float1"].floatValue
        user.height = json["float2"].floatValue
        user.age = json["float3"].floatValue
        user.meals_per_day = Int16(json["float4"].intValue)
        user.diet_note = json["text1"].stringValue
        
        return user
    }
    
    
    func updateUserProfile(id:Int32, user : UserProfile, json: JSON) {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        do {
            let updateduserProfile = setUserProfileData(user: user, json: json)

            do {
                try context.save()
                print("saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
            
        } catch {
            print("Error with request: \(error)")
        }
    }
    
    
    func fetchAllUserProfiles() -> [UserProfile]?{
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserProfile")
//        fetchRequest.returnsObjectsAsFaults = false
        do {
            let people = try managedContext.fetch(fetchRequest)
            return people as? [UserProfile]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func fetchUserProfile(id: Int32)->UserProfile? {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserProfile")
        fetchRequest.predicate = NSPredicate(format: "id == %@" ,id)
        do {
            let data = try managedContext.fetch(fetchRequest) as! [UserProfile]
            
            if (data.count > 0) {
                return data[0]
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    func deleteAll() {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserProfile")
        
        do {
            let data = try managedContext.fetch(fetchRequest) as! [UserProfile]
            for result in data {
                managedContext.delete(result)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
}

