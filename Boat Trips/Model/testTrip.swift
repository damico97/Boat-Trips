//
//  File.swift
//  Boat Trips
//
//  Created by Joey Damico on 7/3/20.
//  Copyright © 2020 Joey Damico. All rights reserved.
//

import Foundation

class testTrip {
    var date: String
    var locationStart: String
    var locationEnd: String
    var hoursPort: Double
    var hoursStarboard: Double
    
    init(date: String, locationStart: String, locationEnd: String, hoursPort: Double, hoursStarboard: Double) {
        self.date = date
        self.locationStart = locationStart
        self.locationEnd = locationEnd
        self.hoursPort = hoursPort
        self.hoursStarboard = hoursStarboard
    }
}
