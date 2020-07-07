//
//  SettingsVC.swift
//  Boat Trips
//
//  Created by Joey Damico on 7/6/20.
//  Copyright © 2020 Joey Damico. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var initHoursPort: UITextField!
    @IBOutlet weak var initHoursStarboard: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func setInitHours(_ sender: Any) {
        CoreDataManager.shared.createTrip(date: Date(), locationStart: "Boat Purchased", locationEnd: "", hoursPort: Float(initHoursPort.text!)!, hoursStarboard: Float(initHoursStarboard.text!)!)
    }
    
}
