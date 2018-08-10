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
    
    private func configureTextFieldAndTableView() {
        customTableView.delegate = self
        customTableView.dataSource = self
        nameofListTextField.delegate = self
        
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CustomListViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.nameofListTextField = textField
        print("Text editing began")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.nameofListTextField = textField
        for item in chosenCustomItems {
            if item.nameOfList != textField.text {
                item.nameOfList = textField.text
            }
        }
        print(chosenCustomItems)
        
        print("Text editing ended")

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosenCustomItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = customTableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        cell.customLabel!.text = chosenCustomItems[indexPath.row].itemName
        
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            let deletedItem = chosenCustomItems[indexPath.row]
            print("Deleted Item: \(deletedItem)")
            chosenCustomItems.remove(at: indexPath.row)
            
            CoreDataHelper.delete(item: deletedItem)
            
            print("ChosenCustomItems Array: \(chosenCustomItems)")
            
        }
    }
  
    func itemTextField(textField: UITextField) {
        itemTextField = textField
        itemTextField?.placeholder = "Enter an Item"
    }
    
    
    @IBAction func setTimeButtonAction(_ sender: UIButton) {
        view.endEditing(true)
        print ("pressed button")
    }
    
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



