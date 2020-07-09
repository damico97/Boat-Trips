//
//  FirstViewController.swift
//  Boat Trips
//
//  Created by Joey Damico on 6/29/20.
//  Copyright © 2020 Joey Damico. All rights reserved.
//

import UIKit

class StatisticsVC: UIViewController {

    @IBOutlet weak var totHrPort: UILabel!
    @IBOutlet weak var totHrStarboard: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    override func viewWillAppear(_ animated: Bool) {
        //print(UserDefaults.standard.float(forKey: DefaultKeys.hoursInitPort))
        //print(UserDefaults.standard.float(forKey: DefaultKeys.hoursInitStarboard))
        showTotalHours()
    }
    
    func showTotalHours() {
        totHrPort.text = String(format: "%.2f", CoreDataManager.shared.getTotalHoursPort())
        totHrStarboard.text = String(format: "%.2f", CoreDataManager.shared.getTotalHoursStarboard())
    }
}

