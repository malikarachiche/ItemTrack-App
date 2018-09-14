//
//  CustomListViewController.swift
//  Forget
//
//  Created by Malik Arachiche on 7/26/18.
//  Copyright © 2018 Malik Arachiche. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CustomListViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var setTimeButtonOutlet: UIButton!
    @IBOutlet weak var customTableView: UITableView!
    @IBOutlet weak var nameofListTextField: UITextField!
    
    var itemTextField: UITextField?
    
    // Add an observer that reloads the tableview when new items are added
    var chosenCustomItems = [CustomItem]() {
        /* Observe the notes array,
         if the array changes,
         run the code in the didSet block */
        didSet {
            self.customTableView.reloadData()
        }
    }
    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextFieldAndTableView()
        print("cHOSEN ITEMS: \(chosenCustomItems.count)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // Initializes table view and text field
    private func configureTextFieldAndTableView() {
        customTableView.delegate = self
        customTableView.dataSource = self
        nameofListTextField.delegate = self
        
    }
    // If user taps anywhere on the screen, keyboard disappears
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CustomListViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    // if user taps anywhere on screen, endEditing is called
    @objc func handleTap() {
        view.endEditing(true)
    }
    // Makes name of list = whatever user inputs
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.nameofListTextField = textField
        print("Text editing began")
    }
    // Makes name of list = whatever user inputs
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.nameofListTextField = textField
        for item in chosenCustomItems {
            if item.nameOfList != textField.text {
                item.nameOfList = textField.text
            }
        }
        print(chosenCustomItems)
        print("Count: \(chosenCustomItems.count)")
        
        print("Text editing ended")

    }
    // removes keyboard when user clicks return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // number of rows = number of items user inputs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosenCustomItems.count
    }
    // When user adds an item, it gets called here and is printed onto the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = customTableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        cell.customLabel!.text = chosenCustomItems[indexPath.row].itemName
        
       
        return cell
    }
    // Takes care of deleting items that user inputted
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            let deletedItem = chosenCustomItems[indexPath.row]
            print("Deleted Item: \(deletedItem)")
            chosenCustomItems.remove(at: indexPath.row)
            
            CoreDataHelper.delete(item: deletedItem)
            
            print("ChosenCustomItems Array: \(chosenCustomItems)")
            
        }
    }
    
    // Placeholder text for text field
    func itemTextField(textField: UITextField) {
        itemTextField = textField
        itemTextField?.placeholder = "Enter an Item"
    }
    
    // When button is pressed, transfer custom list into next screen via Core Data
    // NOT FULLY FUNCTIONAL YET, STILL IN PROGRESS!!!
    @IBAction func setTimeButtonAction(_ sender: UIButton) {
        view.endEditing(true)
        print ("pressed button")
    }
    
    // When add button is pressed, the item that the user inputted is added to the chosenCustomItems list, and then displayed on the table cells
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        let alert = UIAlertController(title: "Add a New Item", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: itemTextField)
        
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            let singleCustomItem = CoreDataHelper.newCustomItem()
            
            guard let item = alert.textFields?.first?.text else {return}
            singleCustomItem.itemName = item
            singleCustomItem.reminder = true
            
            CoreDataHelper.save()
            
            self.chosenCustomItems.append(singleCustomItem)
            
            for item in self.chosenCustomItems {
                if item.nameOfList == nil {
                    item.nameOfList = self.nameofListTextField.text
                }
            }
            
            print(self.chosenCustomItems)
        }
        
        alert.addAction(action)
        present(alert, animated: true)
        
        print ("Button Works")
    }
    
}



