//
//  TripsFormVC.swift
//  Boat Trips
//
//  Created by Joey Damico on 7/6/20.
//  Copyright © 2020 Joey Damico. All rights reserved.
//

import UIKit

class TripsFormVC: UIViewController {

    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var locationStartTF: UITextField!
    @IBOutlet weak var locationEndTF: UITextField!
    @IBOutlet weak var locationTurnTF: UITextField!
    @IBOutlet weak var hoursPortTF: UITextField!
    @IBOutlet weak var hoursStarboardTF: UITextField!
    
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getDate()
        createToolBar()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TripsFormVC.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        datePicker?.addTarget(self, action: #selector(TripsFormVC.dateChanged(datePicker:)), for: .valueChanged)

        
        dateTF.inputView = datePicker
    }

    @IBAction func doneClicked(_ sender: Any) {
        if checkForm() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy - hh:mm a"
            let sumbitDate = dateFormatter.date(from:dateTF.text!)!
            
            let lastTrip = CoreDataManager.shared.fetchNewestTrip()
            
            let tripHrPort = Float(hoursPortTF.text!)! - lastTrip![0].hoursPort
            let tripHrStarboard = Float(hoursStarboardTF.text!)! - lastTrip![0].hoursStarboard
            print(tripHrPort, tripHrStarboard)
            
            
            CoreDataManager.shared.createTrip(date: sumbitDate, locationStart: locationStartTF.text ?? "", locationEnd: locationEndTF.text ?? "", locationTurn: locationTurnTF.text ?? "", hoursPort: Float(hoursPortTF.text!)!, hoursStarboard: Float(hoursStarboardTF.text!)!, tripHoursPort: tripHrPort, tripHoursStarboard: tripHrStarboard, notes: "")
            
            self.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "submit", sender: self)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func getDate() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY - hh:mm a"
        
        dateTF.text = dateFormatter.string(from: currentDate)
    }
    
    func checkForm() -> Bool {
        if locationStartTF.text == "" || locationEndTF.text == "" {
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
        dateFormatter.dateFormat = "MM/dd/YYYY - hh:mm a"
        dateTF.text = dateFormatter.string(from: datePicker.date)
        //dismissKeyboard()
    }
    
    func createToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(TripsFormVC.dismissKeyboard))
        let dateButton = UIBarButtonItem(title: "Date", style: .plain, target: self, action: #selector(TripsFormVC.setPickerToDate))
        let timeButton = UIBarButtonItem(title: "Time", style: .plain, target: self, action: #selector(TripsFormVC.setPickerToTime))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([dateButton, timeButton, spacer, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        dateTF.inputAccessoryView = toolBar
    }
    
    @objc func setPickerToDate() {
        datePicker?.datePickerMode = .date
    }
    
    @objc func setPickerToTime() {
        datePicker?.datePickerMode = .dateAndTime
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
