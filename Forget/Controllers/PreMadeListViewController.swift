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
    
    var itemArray = [[
        Items(type: "Essentials", item: "Keys"),
        Items(type: "Essentials", item: "Phone"),
        Items(type: "Essentials", item: "Headphones"),
        Items(type: "Essentials", item: "Wallet"),
        Items(type: "Essentials", item: "Identification"),
        Items(type: "Essentials", item: "Charger")
        ],
                     [
                        Items(type: "Travel", item: "Bags"),
                        Items(type: "Travel", item: "Clothes"),
                        Items(type: "Travel", item: "Electronics"),
                        Items(type: "Travel", item: "Food"),
                        Items(type: "Travel", item: "Toiletries")
                        
        ],
                     [
                        Items(type: "Work", item: "Laptop"),
                        Items(type: "Work", item: "Lunch"),
                        Items(type: "Work", item: "Presentation Materials"),
                        Items(type: "Work", item: "Uniform")
        ],
                     [
                        Items(type: "School", item: "Backpack"),
                        Items(type: "School", item: "Homework"),
                        Items(type: "School", item: "Pencils"),
                        Items(type: "School", item: "Pens"),
                        Items(type: "School", item: "Notebook"),
                        Items(type: "School", item: "Binders"),
                        Items(type: "School", item: "Calculator"),
                        Items(type: "School", item: "Lunch")
        ],
                     [
                        Items(type: "Gym/Athletic", item: "Gym Attire"),
                        Items(type: "Gym/Athletic", item: "Sneakers"),
                        Items(type: "Gym/Athletic", item: "Water"),
                        Items(type: "Gym/Athletic", item: "Protein Shake")
        ]
    ]
    var filteredData: [String]!
    var typeSet = Set<String>()
    var chosenItems = [String]()
    
    var essential: Essential!
    var travel: Travel!
    var work: Work!
    var school: School!
    var athletic: Athletic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //essential = CoreDataHelper.retrieveEssentials()
        
        preTableView.delegate = self
        preTableView.dataSource = self
        essential = CoreDataHelper.newEssential()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func _filteredArrayItems(with itemLists: [Items]) -> [String] {
        var filteredArray = [String]()
        
        for item in itemLists {
            filteredArray.append(item.item)
        }
        
        return filteredArray
    }
    
    func _filteredArrayTypes(with itemLists: [Items]) -> [String] {
        var filteredArray = [String]()
        
        for item in itemLists {
            typeSet.insert(item.type)
            
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
        
        cell.textLabel?.text = itemArray[indexPath.row][0].type
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
