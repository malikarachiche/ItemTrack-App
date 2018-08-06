//
//  DataAlarmViewController.swift
//  Forget
//
//  Created by Malik Arachiche on 7/31/18.
//  Copyright © 2018 Malik Arachiche. All rights reserved.
//

import Foundation
import UIKit

class DataAlarmViewController: UITableViewController {
    
    
    @IBOutlet var alarmTableView: UITableView!
    
    private var datePicker = UIDatePicker()
    
    var chosenItems = [[PreMadeItem]]()
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.addTarget(self, action: #selector(DataAlarmViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DataAlarmViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        //dateTextField.inputView = datePicker
        
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
        view.resignFirstResponder()
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        
        dateFormatter.dateFormat = "h:mm a"
        //dateTextField.text = dateFormatter.string(from: datePicker.date)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosenItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = alarmTableView.dequeueReusableCell(withIdentifier: "AlarmCell", for: indexPath) as! AlarmCell
    
        let chosen = chosenItems[indexPath.row]
        
        cell.titleLabel?.text = chosen[indexPath.row].category
        cell.subLabel?.text = chosen[indexPath.row].name! + "..."
        cell.dateTextField.inputView = datePicker
        cell.dateTextField.text = dateFormatter.string(from: datePicker.date)
        
        //cell.detailTextLabel?.text = _filteredArrayItems(with: itemsList)[indexPath.row]
        
        return cell
    }
 
    @IBAction func alarmButton(_ sender: UIButton) {

    }
    
}
