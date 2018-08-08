//
//  AppDelegate.swift
//  Forget
//
//  Created by Malik Arachiche on 7/24/18.
//  Copyright © 2018 Malik Arachiche. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,  UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    // Allows Notifications while the app is running
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    // Response to the notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier == "ItemListIdentifier" {
//            self.performSegueWithIdentifier("GoToViewController", sender:self)

            print ("Handling notification with identifier 'ItemListIdentifier'")
            
            // add segue here if this fails, try inside the completion handler
        }
        // Write the function definition, and code that runs
        // This is just the function call
        
        completionHandler()
    }
    
    private func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        if application.applicationState == .inactive || application.applicationState == .background {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let navigationController = self.window?.rootViewController as? UINavigationController
            let destinationController = storyboard.instantiateViewController(withIdentifier: "dashboard") as? ConfirmViewController
            navigationController?.pushViewController(destinationController!, animated: false)
        }
    }
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        
        // Requests user if they will allow Notifications the first time they launch the app.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            print("Granted: \(granted)")
        }
        
        
        // Override point for customization after application launch.
        let preMadeItems = CoreDataHelper.retrievePreMadeItems()
        print(preMadeItems.count)
        if preMadeItems.count == 0 {
            populateCoreData()
        }
        
        let customItems = CoreDataHelper.retrieveCustomItems()
        if customItems == [] {
//            populateCoreData()
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Forget")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func populateCoreData() {
        // make each coredata item before saving
        let keys = CoreDataHelper.newPreMadeItem()
        keys.category = "Essentials"
        keys.name = "Keys"
        keys.reminder = false
        
        let phone = CoreDataHelper.newPreMadeItem()
        phone.category = "Essentials"
        phone.name = "Phone"
        phone.reminder = false
        
        let headphones = CoreDataHelper.newPreMadeItem()
        headphones.category = "Essentials"
        headphones.name = "Headphones"
        headphones.reminder = false
        
        let wallet = CoreDataHelper.newPreMadeItem()
        wallet.category = "Essentials"
        wallet.name = "Wallet"
        wallet.reminder = false
        
        let identification = CoreDataHelper.newPreMadeItem()
        identification.category = "Essentials"
        identification.name = "Identification"
        identification.reminder = false
        
        let charger = CoreDataHelper.newPreMadeItem()
        charger.category = "Essentials"
        charger.name = "Charger"
        charger.reminder = false
        
        let luggage = CoreDataHelper.newPreMadeItem()
        luggage.category = "Travel"
        luggage.name = "Luggage"
        luggage.reminder = false
        
        let clothes = CoreDataHelper.newPreMadeItem()
        clothes.category = "Travel"
        clothes.name = "Clothes"
        clothes.reminder = false
        
        let electronics = CoreDataHelper.newPreMadeItem()
        electronics.category = "Travel"
        electronics.name = "Electronics"
        electronics.reminder = false
        
        let food = CoreDataHelper.newPreMadeItem()
        food.category = "Travel"
        food.name = "Food"
        food.reminder = false
        
        let toiletries = CoreDataHelper.newPreMadeItem()
        toiletries.category = "Travel"
        toiletries.name = "Toiletries"
        toiletries.reminder = false
        
        let laptop = CoreDataHelper.newPreMadeItem()
        laptop.category = "Work"
        laptop.name = "Laptop"
        laptop.reminder = false
        
        let lunch = CoreDataHelper.newPreMadeItem()
        lunch.category = "Work"
        lunch.name = "Lunch"
        lunch.reminder = false
        
        let presentationMaterials = CoreDataHelper.newPreMadeItem()
        presentationMaterials.category = "Work"
        presentationMaterials.name = "Presentation Materials"
        presentationMaterials.reminder = false
        
        let uniform = CoreDataHelper.newPreMadeItem()
        uniform.category = "Work"
        uniform.name = "Uniform"
        uniform.reminder = false
        
        let backpack = CoreDataHelper.newPreMadeItem()
        backpack.category = "School"
        backpack.name = "Backpack"
        backpack.reminder = false
        
        let homework = CoreDataHelper.newPreMadeItem()
        homework.category = "School"
        homework.name = "Homework"
        homework.reminder = false
        
        let pencils = CoreDataHelper.newPreMadeItem()
        pencils.category = "School"
        pencils.name = "Pencils"
        pencils.reminder = false
        
        let pens = CoreDataHelper.newPreMadeItem()
        pens.category = "School"
        pens.name = "Pens"
        pens.reminder = false
        
        let notebook = CoreDataHelper.newPreMadeItem()
        notebook.category = "School"
        notebook.name = "Notebook"
        notebook.reminder = false
        
        let binder = CoreDataHelper.newPreMadeItem()
        binder.category = "School"
        binder.name = "Binder"
        binder.reminder = false
        
        let calculator = CoreDataHelper.newPreMadeItem()
        calculator.category = "School"
        calculator.name = "Calculator"
        calculator.reminder = false
        
        let lunches = CoreDataHelper.newPreMadeItem()
        lunches.category = "School"
        lunches.name = "Lunch"
        lunches.reminder = false
        
        let shorts = CoreDataHelper.newPreMadeItem()
        shorts.category = "Gym/Athletic"
        shorts.name = "Shorts"
        shorts.reminder = false
        
        let shirt = CoreDataHelper.newPreMadeItem()
        shirt.category = "Gym/Athletic"
        shirt.name = "Shirt"
        shirt.reminder = false
        
        let sneakers = CoreDataHelper.newPreMadeItem()
        sneakers.category = "Gym/Athletic"
        sneakers.name = "Sneakers"
        sneakers.reminder = false
        
        let water = CoreDataHelper.newPreMadeItem()
        water.category = "Gym/Athletic"
        water.name = "Water"
        water.reminder = false
        
        let proteinShake = CoreDataHelper.newPreMadeItem()
        proteinShake.category = "Gym/Athletic"
        proteinShake.name = "Protein Shake"
        proteinShake.reminder = false
        
        CoreDataHelper.save()
    }
    


}

