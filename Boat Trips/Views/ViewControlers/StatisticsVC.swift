//
//  FirstViewController.swift
//  Boat Trips
//
//  Created by Joey Damico on 6/29/20.
//  Copyright © 2020 Joey Damico. All rights reserved.
//

import UIKit

class StatisticsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    override func viewWillAppear(_ animated: Bool) {
        print(UserDefaults.standard.float(forKey: Defaults.hoursInitPort))
        print(UserDefaults.standard.float(forKey: Defaults.hoursInitStarboard))
    }
}

