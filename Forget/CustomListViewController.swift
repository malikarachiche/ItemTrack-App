//
//  CustomListViewController.swift
//  Forget
//
//  Created by Malik Arachiche on 7/26/18.
//  Copyright © 2018 Malik Arachiche. All rights reserved.
//

import Foundation
import UIKit

class CustomListViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var setTimeButtonOutlet: UIButton!
    @IBOutlet weak var customTableView: UITableView!
    
//    var itemsList = [Items]()
    
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

        
        searchBar.delegate = (self as UISearchBarDelegate)
        customTableView.delegate = self
        customTableView.isHidden = true
        customTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = customTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
//        filteredData = searchText.isEmpty ? itemsList : itemsList.filter({(dataItems) -> Bool in
//            // If dataItem matches the searchText, return true to include it
//            return dataItems.item.range(of: searchText, options: .caseInsensitive) != nil
//        })
        let listOfItems = _filteredArray(with: itemsList)
        filteredData = searchText.isEmpty ? listOfItems : listOfItems.filter { (item) in
            return item.range(of: searchText, options: .caseInsensitive) != nil
        }
        
        customTableView.reloadData()
    }
    
    func _filteredArray(with itemLists: [Items]) -> [String] {
        var filteredArray = [String]()
        
        for item in itemLists {
            filteredArray.append(item.item)
        }
        
        return filteredArray
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        customTableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenItems.append(filteredData[indexPath.row])
        print(chosenItems)
        
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        customTableView.isHidden = true
        
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        customTableView.isHidden = false
        searchBar.text = ""
    }
    
    func performSearch(words: [String], term: String) -> [String] {
        var results: [String] = []
        for word in words {
            if word.range(of: term) != nil {
                results.append(word)
            }
        }
        return results
    }
    
    @IBAction func setTimeButtonAction(_ sender: UIButton) {
        print ("pressed button")
    }
    
    
}



