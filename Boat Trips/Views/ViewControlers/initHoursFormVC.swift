//
//  initHoursFormVC.swift
//  Boat Trips
//
//  Created by Joey on 7/9/20.
//  Copyright © 2020 Joey Damico. All rights reserved.
//

import UIKit

class InitHoursFormVC: UIViewController {

    @IBOutlet weak var initHoursPort: UITextField!
    @IBOutlet weak var initHoursStarboard: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TripsFormVC.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(InitHoursFormVC.dateChanged(datePicker:)), for: .valueChanged)
        
        dateTF.inputView = datePicker
    }
    
    @IBAction func setInitHours(_ sender: Any) {
        if checkForm() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd, yyyy"
            let submitDate = dateFormatter.date(from:dateTF.text!)!
            print(submitDate)
            
            CoreDataManager.shared.createTrip(date: submitDate, locationStart: "Boat Purchased", locationEnd: "", hoursPort: Float(initHoursPort.text!)!, hoursStarboard: Float(initHoursStarboard.text!)!, tripHoursPort: 0.0, tripHoursStarboard: 0.0)
            
            UserDefaults.standard.set(Float(initHoursPort.text!)!, forKey: DefaultKeys.hoursInitPort)
            UserDefaults.standard.set(Float(initHoursStarboard.text!)!, forKey: DefaultKeys.hoursInitStarboard)
            UserDefaults.standard.set(Bool(true), forKey: DefaultKeys.hoursSet)
        }
    }
    
    func checkForm() -> Bool {
        if initHoursPort.text == "" || initHoursStarboard.text == "" || dateTF.text == "" {
            return false
        } else {
            return true
        }
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, YYYY"
        dateTF.text = dateFormatter.string(from: datePicker.date)
        dismissKeyboard()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}