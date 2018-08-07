//
//  DataAlarmViewController.swift
//  Forget
//
//  Created by Malik Arachiche on 7/31/18.
//  Copyright © 2018 Malik Arachiche. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class DataAlarmViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet var alarmTableView: UITableView!
    
    private var datePicker = UIDatePicker()
    
    var chosenItems = [[PreMadeItem]]()
    let dateFormatter = DateFormatter()
    
    var currentTextField: UITextField? = nil
    var selectedIndex: IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "h:mm a"
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.addTarget(self, action: #selector(DataAlarmViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DataAlarmViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        //dateTextField.inputView = datePicker
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
        view.resignFirstResponder()
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        print(dateFormatter.string(from: datePicker.date))
        if let currentTextField = currentTextField {
            currentTextField.text = dateFormatter.string(from: datePicker.date)
           
            // update chosen items at selected index
            //chosenItems[(selectedIndex?.row)!].date = datePicker.date
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.currentTextField = textField
        
        let cell: UITableViewCell = textField.superview!.superview as! UITableViewCell
        
        selectedIndex = tableView.indexPath(for: cell)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.currentTextField = nil
        
        CoreDataHelper.save()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select Cell: \(indexPath.row)")
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
        //cell.dateTextField.text = dateFormatter.string(from: datePicker.date)
        cell.dateTextField.delegate = self
        
        //cell.detailTextLabel?.text = _filteredArrayItems(with: itemsList)[indexPath.row]
        CoreDataHelper.save()
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        
        switch identifier {
        case "ConfirmSegue":
            let destination = segue.destination as! ConfirmViewController
            destination.chosenItems = chosenItems
        default:
            print("")
        }
        
    }

    @IBAction func alarmButton(_ sender: UIButton) {
        
        let content = UNMutableNotificationContent()
        // Fill these in with appropriate data later
        content.title = "Get your Items!"
        content.body = "Body"
        
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "ItemListIdentifier", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

    }
    
}
