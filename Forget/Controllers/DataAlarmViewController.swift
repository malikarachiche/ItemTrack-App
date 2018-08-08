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
    
    var essentialArray = [PreMadeItem]()
    var travelArray = [PreMadeItem]()
    var workArray = [PreMadeItem]()
    var schoolArray = [PreMadeItem]()
    var gymArray = [PreMadeItem]()
    var newArray = [[PreMadeItem]]()
    var chosenItems = [[PreMadeItem]]()
    let dateFormatter = DateFormatter()
    
    var currentTextField: UITextField? = nil
    var selectedIndex: IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coreData = CoreDataHelper.retrievePreMadeItems()
        
        for item in coreData {
            switch item.category {
            case "Essentials":
                essentialArray.append(item)
            case "Travel":
                travelArray.append(item)
            case "Work":
                workArray.append(item)
            case "School":
                schoolArray.append(item)
            case "Gym/Athletic":
                gymArray.append(item)
            default:
                print ("lol")
            }
        }
        
        newArray.append(essentialArray)
        newArray.append(travelArray)
        newArray.append(gymArray)
        newArray.append(workArray)
        newArray.append(schoolArray)
        
        for item in newArray {
            if item[0].reminder == true {
                chosenItems.append(item)
            }
        }
        
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
     
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.currentTextField = nil
        let cell: UITableViewCell = textField.superview!.superview as! UITableViewCell
        
        selectedIndex = tableView.indexPath(for: cell)
        
        chosenItems[(selectedIndex?.row)!][0].setTime = datePicker.date
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
        
        cell.titleLabel?.text = chosen[0].category
        let text = "\(chosen[0].name!), \(chosen[1].name!)..."
        
        
        cell.subLabel.text = text
        cell.dateTextField.inputView = datePicker
        if chosen[0].setTime != nil {
            cell.dateTextField.text = dateFormatter.string(from: chosen[0].setTime!)
        }
        //cell.dateTextField.text = dateFormatter.string(from: datePicker.date)
        cell.dateTextField.delegate = self
        
        //cell.detailTextLabel?.text = _filteredArrayItems(with: itemsList)[indexPath.row]
        CoreDataHelper.save()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            chosenItems.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        
        switch identifier {
        case "ConfirmSegue":
            let destination = segue.destination as! ConfirmViewController
            destination.chosenItems = chosenItems
            print(chosenItems)
        default:
            print("")
        }
        
    }

    @IBAction func alarmButton(_ sender: UIButton) {
        
        //Here i want to add the times to all the premade items
        
        
        //MARK: NOTIFICATION SETUP
        
        let content = UNMutableNotificationContent()
        // Fill these in with appropriate data later
        content.title = "Get your Items!"
        content.body = chosenItems[0][0].category!
        
        content.sound = UNNotificationSound.default()
        
        let dateComponent = datePicker.calendar.dateComponents([.hour, .minute], from: datePicker.date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        let request = UNNotificationRequest(identifier: "ItemListIdentifier", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

    }
    
}
