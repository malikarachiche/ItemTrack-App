//
//  PreMadeListViewController.swift
//  Forget
//
//  Created by Malik Arachiche on 7/27/18.
//  Copyright © 2018 Malik Arachiche. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class PreMadeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var setTimeButton: UIButton!
    @IBOutlet weak var preTableView: UITableView!
    
    let cellID = "PreMadeCell"
    var lastSelectedRow = 0
 
    var itemArray = [[PreMadeItem]]()
    var essentialArray = [PreMadeItem]()
    var travelArray = [PreMadeItem]()
    var workArray = [PreMadeItem]()
    var schoolArray = [PreMadeItem]()
    var gymArray = [PreMadeItem]()
    
    var filteredData: [String]!
    var typeSet = Set<String>()
    var chosenItems = [[PreMadeItem]]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        
        let preMadeItems = CoreDataHelper.retrievePreMadeItems()
        
        for item in preMadeItems {
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
        
        itemArray.append(essentialArray)
        itemArray.append(travelArray)
        itemArray.append(gymArray)
        itemArray.append(workArray)
        itemArray.append(schoolArray)
        
        // go through each category in the item array
        // if the reminder of the first item is true add it to the selected array
        
        for items in itemArray {
            if items[0].reminder == true {
                chosenItems.append(items)
            }
        }
        
        preTableView.delegate = self
        preTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func _filteredArrayItems(with itemLists: [PreMadeItem]) -> [String] {
        // filters array by items
        var filteredArray = [String]()
        
        for item in itemLists {
            filteredArray.append(item.name!)
        }
        
        return filteredArray
    }
    
    func _filteredArrayTypes(with itemLists: [PreMadeItem]) -> [String] {
        // filters array by category
        var filteredArray = [String]()
        
        for item in itemLists {
            typeSet.insert(item.category!)
            
        }
        for item in typeSet {
            filteredArray.append(item)
        }
        return filteredArray
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = preTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PreMadeCell

        cell.topLabel?.text = itemArray[indexPath.row][0].category
        cell.bottomLabel?.text = "Toggle the switch to select the list"
        
        cell.toggleSwitch?.tag = indexPath.row
        
        cell.toggleSwitch.addTarget(self, action: #selector(toggleSwitch(_:)), for: .valueChanged)
        
        cell.toggleSwitch.isOn = itemArray[indexPath.row][0].reminder
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastSelectedRow = indexPath.row
        self.performSegue(withIdentifier: "SecondSegueID", sender: self)
        //essentialsArr.append(indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        
        switch identifier {
        case "SecondSegueID":
            let destination = segue.destination as! SecondTableViewController
            destination.itemArray = itemArray[lastSelectedRow]
        case "SetTimeSegue":
            let destination = segue.destination as! DataAlarmViewController
            
           // destination.chosenItems = chosenItems
            
        default:
            print("")
        }

    }
    
    @objc func toggleSwitch(_ sender: UISwitch) {
        var essentialBool = false
        var travelBool = false
        var workBool = false
        var schoolBool = false
        var gymBool = false
       
        switch sender.tag{
            
        case 0:
            switch sender.isOn{
            case true:
                chosenItems.append(itemArray[0])
                for item in itemArray[0] {
                    item.reminder = true
                    
                }
            case false:
               
                for item in itemArray[0] {
                    item.reminder = false
                }
                for (index, items) in chosenItems.enumerated() {
                    for (_, item) in items.enumerated() {
                        if essentialBool == true {
                            continue
                        }
                        if item.category == "Essentials" {
                             chosenItems.remove(at: index)
                            
                             essentialBool = true
                             continue
                        }
                        continue
                    }
                    if essentialBool == true {
                        continue
                    }
                }
            }
        case 1:
            switch sender.isOn{
            case true:
                chosenItems.append(itemArray[1])
                for item in itemArray[1] {
                    item.reminder = true
                    
                }
                
            case false:
                for item in itemArray[1] {
                    item.reminder = false
                    
                }
                for (index, items) in chosenItems.enumerated() {
                    for (_, item) in items.enumerated() {
                        if travelBool == true {
                            continue
                        }
                        if item.category == "Travel" {
                            chosenItems.remove(at: index)
                            travelBool = true
                            continue
                        }
                        continue
                    }
                    if travelBool == true {
                        continue
                    }
                }
            }
        case 2:
            switch sender.isOn{
            case true:
                chosenItems.append(itemArray[2])
                for item in itemArray[2] {
                    item.reminder = true
                    
                }
                
            case false:
                for item in itemArray[2] {
                    item.reminder = false
                    
                }
                for (index, items) in chosenItems.enumerated() {
                    for (_, item) in items.enumerated() {
                        if gymBool == true {
                            continue
                        }
                        if item.category == "Gym/Athletic" {
                            chosenItems.remove(at: index)
                            gymBool = true
                            continue
                        }
                        continue
                    }
                    if gymBool == true {
                        continue
                    }
                }
            }
        case 3:
            switch sender.isOn{
            case true:
                chosenItems.append(itemArray[3])
                for item in itemArray[3] {
                    item.reminder = true
                    
                }
            case false:
                for item in itemArray[3] {
                    item.reminder = false
                    
                }
                for (index, items) in chosenItems.enumerated() {
                    for (_, item) in items.enumerated(){
                        if workBool == true {
                            continue
                        }
                        if item.category == "Work"{
                            chosenItems.remove(at: index)
                            workBool = true
                            continue
                        }
                    }
                    if workBool == true {
                        continue
                    }
                }
            }
        case 4:
            switch sender.isOn{
            case true:
                chosenItems.append(itemArray[4])
                for item in itemArray[4] {
                    item.reminder = true
                    
                }
            case false:
                for item in itemArray[4] {
                    item.reminder = false
                    
                }
                for (index, items) in chosenItems.enumerated() {
                    for (_, item) in items.enumerated(){
                        if schoolBool == true {
                            continue
                        }
                        if item.category == "School"{
                            chosenItems.remove(at: index)
                            schoolBool = true
                            continue
                        }
                    }
                    if schoolBool == true {
                        continue
                    }
                }
            }
        default: break
        }
    }
    
    @IBAction func setTimeButtonAction(_ sender: UIButton) {
       
        CoreDataHelper.save()
        //self.performSegue(withIdentifier: "SetTimeSegue", sender: self)
    }
}
