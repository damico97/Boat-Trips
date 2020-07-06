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
    
    var t_trips: [testTrip] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tripsTableView.delegate = self
        tripsTableView.dataSource = self
    }
    
    @IBAction func unwindToTripsViewController(segue: UIStoryboardSegue) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.tripsTableView.reloadData()
            }
        }
    }
}

extension TripsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let trips = CoreDataManager.shared.fetchTripsByDate() else { return 0 }
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let trips = CoreDataManager.shared.fetchTripsByDate()
        let trip = (trips?[indexPath.row])!
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell") as! TripsCell
        
        cell.setTripCell(trip: trip)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete", handler: {
            (action, view, completionHandler) in
            
            let trips = CoreDataManager.shared.fetchTripsByDate()
            CoreDataManager.shared.deleteTrip(tripToDelete: (trips?[indexPath.row])!)
            tableView.deleteRows(at: [indexPath], with: .fade)
        })
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        
        return configuration
    }
}

