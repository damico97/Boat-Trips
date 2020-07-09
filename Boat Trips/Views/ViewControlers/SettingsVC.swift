//
//  SettingsVC.swift
//  Boat Trips
//
//  Created by Joey Damico on 7/6/20.
//  Copyright © 2020 Joey Damico. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnSetHours(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: DefaultKeys.hoursSet) {
            let alert = UIAlertController(title: "Alert", message: "You Have Already Set Your Boat's Hours When Purchased", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            self.performSegue(withIdentifier: "setInitHours", sender: self)
        }
    }
}
