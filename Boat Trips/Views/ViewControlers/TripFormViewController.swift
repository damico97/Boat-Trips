//
//  TripFormViewController.swift
//  Boat Trips
//
//  Created by Joey Damico on 7/3/20.
//  Copyright © 2020 Joey Damico. All rights reserved.
//

import UIKit

class TripFormViewController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var endTextField: UITextField!
    @IBOutlet weak var hoursPort: UITextField!
    @IBOutlet weak var hoursStarboard: UITextField!
    
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getDate()
        createToolBar()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(TripFormViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        dateTextField.inputView = datePicker
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        
        /*
        print(dateTextField.text)
        print(startTextField.text)
        print(endTextField.text)
        print(hoursPort.text)
        print(hoursStarboard.text)
        */
        print("Submit")
        
        CoreDataManager.shared.createTrip(locationStart: startTextField.text ?? "", locationEnd: endTextField.text ?? "")
        
        //print("Created \(newEntry)")
        
        guard let trips = CoreDataManager.shared.fetchTrips() else { return }
        
        //print("Trips: \(trips)")
        
        for t in trips {
            print(t.locationStart, t.locationEnd)
        }
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getDate() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        
        dateTextField.text = dateFormatter.string(from: currentDate)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        dismissKeyboard()
    }
    
    func createToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(TripFormViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        dateTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

