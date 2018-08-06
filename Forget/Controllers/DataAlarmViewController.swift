//
//  DataAlarmViewController.swift
//  Forget
//
//  Created by Malik Arachiche on 7/31/18.
//  Copyright © 2018 Malik Arachiche. All rights reserved.
//

import Foundation
import UIKit

class DataAlarmViewController: UITableViewController, UITextFieldDelegate {
    
    
    @IBOutlet var alarmTableView: UITableView!
    
    private var datePicker = UIDatePicker()
    // [["Hello"], ["HI], ["HOla"]]
    
    
    
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
           
            // update choosen items at selected index
//            chosenItems[(selectedIndex?.row)!].date = datePicker.date
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Hello")
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
    
//    override func delete(_ sender: Any?) {
//        CoreDataHelper.delete(item: chosenItems[(selectedIndex?.row)!][selectedIndex])
//    }
//
    @IBAction func alarmButton(_ sender: UIButton) {
        
    }
    
}
