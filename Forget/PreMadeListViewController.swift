//
//  PreMadeListViewController.swift
//  Forget
//
//  Created by Malik Arachiche on 7/27/18.
//  Copyright © 2018 Malik Arachiche. All rights reserved.
//

import Foundation
import UIKit

class PreMadeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var setTimeButton: UIButton!
    @IBOutlet weak var preTableView: UITableView!
    
    let cellID = "PreMadeCell"
    var itemsList = [
        Items(type: "Essentials", item: "Keys"),
        Items(type: "Essentials", item: "Phone"),
        Items(type: "Essentials", item: "Headphones"),
        Items(type: "Essentials", item: "Wallet"),
        Items(type: "Essentials", item: "Identification"),
        Items(type: "Essentials", item: "Charger"),
        
        Items(type: "Travel", item: "Bags"),
        Items(type: "Travel", item: "Clothes"),
        Items(type: "Travel", item: "Electronics"),
        Items(type: "Travel", item: "Food"),
        Items(type: "Travel", item: "Toiletries"),
        
        Items(type: "Work", item: "Laptop"),
        Items(type: "Work", item: "Lunch"),
        Items(type: "Work", item: "Presentation Materials"),
        Items(type: "Work", item: "Uniform"),
        
        Items(type: "School", item: "Backpack"),
        Items(type: "School", item: "Homework"),
        Items(type: "School", item: "Pencils"),
        Items(type: "School", item: "Pens"),
        Items(type: "School", item: "Notebook"),
        Items(type: "School", item: "Binders"),
        Items(type: "School", item: "Calculator"),
        Items(type: "School", item: "Lunch"),
        
        Items(type: "Gym/Athletic", item: "Gym Attire"),
        Items(type: "Gym/Athletic", item: "Sneakers"),
        Items(type: "Gym/Athletic", item: "Water"),
        Items(type: "Gym/Athletic", item: "Protein Shake"),
    ]
    
    var filteredData: [String]!
    
    var chosenItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preTableView.delegate = self
        preTableView.dataSource = self
        
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
            filteredArray.append(item.type)
        }
        
        return filteredArray
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _filteredArrayTypes(with: itemsList).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = preTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.textLabel?.text = _filteredArrayTypes(with: itemsList)[indexPath.row]
        
        return cell
    }

    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {

    }


    
    @IBAction func setTimeButtonAction(_ sender: UIButton) {
    }
}
