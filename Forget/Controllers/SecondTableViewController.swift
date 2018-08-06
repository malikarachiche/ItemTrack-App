//
//  SecondTableViewController.swift
//  Forget
//
//  Created by Malik Arachiche on 7/30/18.
//  Copyright © 2018 Malik Arachiche. All rights reserved.
//

import Foundation
import UIKit

class SecondTableViewController: UITableViewController {
    
    @IBOutlet var secondTableView: UITableView!
    
    var itemArray: [PreMadeItem]!
    
    let cellID = "SecondTableViewCell"
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = secondTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        
        cell.textLabel?.text = itemArray[indexPath.row].name
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
