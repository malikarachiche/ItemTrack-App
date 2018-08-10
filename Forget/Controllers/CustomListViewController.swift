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
    
    var chosenCustomItems = [CustomItem]()
    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextFieldAndTableView()
        //itemsList = CoreDataHelper.retrieveItems()
        //searchBar.delegate = (self as UISearchBarDelegate)
        
        
        
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
        
        print("Text editing ended")

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = customTableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        cell.customLabel?.text = self.chosenCustomItems[indexPath.row].itemName
       
        return cell
    }
    
    func _filteredArray(with itemLists: [Items]) -> [String] {
        var filteredArray = [String]()
        
        for item in itemLists {
            filteredArray.append(item.item)
        }
        
        return filteredArray
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



