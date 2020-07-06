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
    @IBOutlet weak var hoursPortTF: UITextField!
    @IBOutlet weak var hoursStarboard: UITextField!
    
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getDate()
        
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
            
            CoreDataManager.shared.createTrip(date: sumbitDate, locationStart: locationStartTF.text ?? "", locationEnd: locationEndTF.text ?? "")
            
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
        dismissKeyboard()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
