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
    
    
    
    var chosenItems = [[PreMadeItem]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
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
        }
        else {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        
    }
    
    
    
    
    
}
