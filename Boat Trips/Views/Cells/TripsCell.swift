//
//  TripsCell.swift
//  Boat Trips
//
//  Created by Joey Damico on 7/2/20.
//  Copyright © 2020 Joey Damico. All rights reserved.
//

import UIKit

class TripsCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var locationStart: UILabel!
    @IBOutlet weak var locationEnd: UILabel!
    @IBOutlet weak var hoursPort: UILabel!
    @IBOutlet weak var hoursStarboard: UILabel!
    
    func setTripCell(trip: testTrip) {
        date.text = trip.date
        locationStart.text = trip.locationStart
        locationEnd.text = trip.locationEnd
        hoursPort.text = String(format: "%.2f", trip.hoursPort)
        hoursStarboard.text = String(format: "%.2f", trip.hoursStarboard)
    }
    
}
