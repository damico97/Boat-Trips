//
//  TripViewerVC.swift
//  Boat Trips
//
//  Created by Joey on 7/9/20.
//  Copyright © 2020 Joey Damico. All rights reserved.
//

import UIKit

class TripViewerVC: UIViewController {
    
    var data: TripData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(data?.locationStart)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
