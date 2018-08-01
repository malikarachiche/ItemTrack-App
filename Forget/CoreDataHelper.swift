//
//  CoreDataHelper.swift
//  Forget
//
//  Created by Malik Arachiche on 8/1/18.
//  Copyright © 2018 Malik Arachiche. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct CoreDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    static func newCustomItem() -> CustomItem {
        let customItem = NSEntityDescription.insertNewObject(forEntityName: "CustomItem", into: context) as! CustomItem
        
        return customItem
    }
    
    static func newAthletic() -> Athletic {
        let athletic = NSEntityDescription.insertNewObject(forEntityName: "Athletic", into: context) as! Athletic
        
        return athletic
    }
    
    static func newEssential() -> Essential {
        let essential = NSEntityDescription.insertNewObject(forEntityName: "Essential", into: context) as! Essential
        
        return essential
    }
    
    static func newSchool() -> School {
        let school = NSEntityDescription.insertNewObject(forEntityName: "School", into: context) as! School
        
        return school
    }
    
    static func newTravel() -> Travel {
        let travel = NSEntityDescription.insertNewObject(forEntityName: "Travel", into: context) as! Travel
        
        return travel
    }
    
    static func newWork() -> Work {
        let work = NSEntityDescription.insertNewObject(forEntityName: "Work", into: context) as! Work
        
        return work
    }
    
    static func save() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func delete(item: CustomItem) {
        context.delete(item)
        
        save()
    }
    
    static func retrieveEssentials() -> [Essential] {
        do {
            let fetchRequest = NSFetchRequest<Essential>(entityName: "Essential")
            let results = try context.fetch(fetchRequest)
            
            return results
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
    
    static func retrieveItems() -> [CustomItem] {
        do {
            let fetchRequest = NSFetchRequest<CustomItem>(entityName: "CustomItem")
            let results = try context.fetch(fetchRequest)
            
            return results
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
}


