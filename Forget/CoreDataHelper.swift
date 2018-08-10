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
    
    static func newPreMadeItem() -> PreMadeItem {
        let preMadeItem = NSEntityDescription.insertNewObject(forEntityName: "PreMadeItem", into: context) as! PreMadeItem
        
        return preMadeItem
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
        print(item)
        save()
    }
    
    static func deletePremade(item: PreMadeItem) {
        context.delete(item)
        save()
    }

    static func deleteItems() {
        
    }
    
    static func retrievePreMadeItems() -> [PreMadeItem] {
        do {
            let fetchRequest = NSFetchRequest<PreMadeItem>(entityName: "PreMadeItem")
            let results = try context.fetch(fetchRequest)
            
            return results
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
    
    static func retrieveCustomItems() -> [CustomItem] {
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


