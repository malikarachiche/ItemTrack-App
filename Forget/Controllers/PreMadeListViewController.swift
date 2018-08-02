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
    var chosenItems = [PreMadeItem]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        print (itemArray)
        
        preTableView.delegate = self
        preTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func _filteredArrayItems(with itemLists: [PreMadeItem]) -> [String] {
        var filteredArray = [String]()
        
        for item in itemLists {
            filteredArray.append(item.name!)
        }
        
        return filteredArray
    }
    
    func _filteredArrayTypes(with itemLists: [PreMadeItem]) -> [String] {
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
        let cell = preTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
//        let cell = preTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row][0].category
        //cell.detailTextLabel?.text = _filteredArrayItems(with: itemsList)[indexPath.row]
        
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
//        case "SetTimeSegue":
//            let destination = segue.destination as! DataAlarmViewController
        default:
            print("")
        }

    }
    
    @IBAction func toggleSwitch(_ sender: UISwitch) {
        print ("Toggled")
        
        //print (CoreDataHelper.retrieveEssentials())
        //chosenItems.append(itemArray[lastSelectedRow])
    }
    
    
    @IBAction func setTimeButtonAction(_ sender: UIButton) {
        CoreDataHelper.save()
        print ("Saved")
    }
}
