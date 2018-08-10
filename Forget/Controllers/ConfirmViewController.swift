//
//  ConfirmViewController.swift
//  Forget
//
//  Created by Malik Arachiche on 8/6/18.
//  Copyright © 2018 Malik Arachiche. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class ConfirmViewController: UITableViewController {
    
    var maxCount: Int = 0
    var count: Int = 0
    
    var essentialArray = [PreMadeItem]()
    var travelArray = [PreMadeItem]()
    var workArray = [PreMadeItem]()
    var schoolArray = [PreMadeItem]()
    var gymArray = [PreMadeItem]()
    var newArray = [[PreMadeItem]]()
    var chosenItems = [[PreMadeItem]]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
        for item in chosenItems {
            maxCount += item.count
            
        }
    }
    
    func fetchData()  {
        let coreData = CoreDataHelper.retrievePreMadeItems()
        
        newArray = []
        chosenItems = []
        
        for item in coreData {
            switch item.category {
            case "Essentials":
                essentialArray.append(item)
            case "Travel":
                travelArray.append(item)
            case "Work":
                workArray.append(item)
            case "School":
                schoolArray.append(item)
            case "Gym/Athletic":
                gymArray.append(item)
            default:
                print ("lol")
            }
        }
        
        newArray.append(essentialArray)
        newArray.append(travelArray)
        newArray.append(gymArray)
        newArray.append(workArray)
        newArray.append(schoolArray)
        
        for item in newArray {
            if item.count > 0 {
                let itm : PreMadeItem? = item[0]
                if itm != nil{
                    if item[0].reminder == true {
                        chosenItems.append(item)
                        
                    }
                }
            }
        }
        CoreDataHelper.save()
    }
   
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return chosenItems[section][0].category
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chosenItems.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosenItems[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConfirmCell", for: indexPath) as! ConfirmCell
        
        cell.itemLabel?.text = chosenItems[indexPath.section][indexPath.row].name
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            count -= 1
            
            
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            count += 1
            
            if count == maxCount {
                let alert = UIAlertController(title: "Congrats!", message: "You Got Everything!", preferredStyle: UIAlertControllerStyle.alert)
                present(alert, animated: true)
                alert.addAction(UIAlertAction(title: "Esketit", style: UIAlertActionStyle.cancel, handler: nil))
                return
            }
           
        }
        
    }
    
    
    
    
    
}
