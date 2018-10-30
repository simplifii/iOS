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
        
        let user = NSEntityDescription.insertNewObject(forEntityName: "UserProfile", into: managedContext) as! UserProfile
        
        user.id = Int32(json["id"].intValue)
        user.uniqueCode = json["unique_code"].stringValue
        user.mealsPerDay = Int16(json["float4"].intValue)
        user.calories = Int16(json["int2"].intValue)
        user.carbs = Int16(json["int3"].intValue)
        user.protein = Int16(json["int4"].intValue)
        user.fat = Int16(json["int5"].intValue)
        user.dietaryPreference = json["cdata"]["dietary_preference"].stringValue
        
        do {
            try managedContext.save()
            return user
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    
    func fetchAllUserProfiles() -> [UserProfile]?{
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserProfile")
        do {
            let people = try managedContext.fetch(fetchRequest)
            return people as? [UserProfile]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
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

