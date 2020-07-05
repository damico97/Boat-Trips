//
//  SecondViewController.swift
//  Boat Trips
//
//  Created by Joey Damico on 6/29/20.
//  Copyright © 2020 Joey Damico. All rights reserved.
//

import UIKit

class TripsViewController: UIViewController {
    
    @IBOutlet weak var tripsTableView: UITableView!
    var trips: [testTrip] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        trips = createArray()
        
        tripsTableView.delegate = self
        tripsTableView.dataSource = self
    }

    func createArray() -> [testTrip] {
        var tempTrips: [testTrip] = []
        
        let trip1 = testTrip(date: "May 8, 2020", locationStart: "New Gretna, NJ", locationEnd: "Long Branch, NJ", hoursPort: 5.22, hoursStarboard: 5.39)
        let trip2 = testTrip(date: "May 30, 2020", locationStart: "Long Branch, NJ", locationEnd: "Long Branch, NJ", hoursPort: 2.64, hoursStarboard: 2.62)
        let trip3 = testTrip(date: "Jun 14, 2020", locationStart: "Long Branch, NJ", locationEnd: "Long Branch, NJ", hoursPort: 3.06, hoursStarboard: 3.03)
        let trip4 = testTrip(date: "Jun 27, 2020", locationStart: "Long Branch, NJ", locationEnd: "Belmar, NJ", hoursPort: 2.72, hoursStarboard: 2.68)
        let trip5 = testTrip(date: "Jun 28, 2020", locationStart: "Belmar, NJ", locationEnd: "Long Branch, NJ", hoursPort: 2.4, hoursStarboard: 2.38)
        
        tempTrips.append(trip5)
        tempTrips.append(trip4)
        tempTrips.append(trip3)
        tempTrips.append(trip2)
        tempTrips.append(trip1)
        
        return tempTrips
    }
}

extension TripsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let trip = trips[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell") as! TripsCell
        
        cell.setTripCell(trip: trip)
        
        return cell
    }
}

