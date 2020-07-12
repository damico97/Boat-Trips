//
//  CoreDataManager.swift
//  Boat Trips
//
//  Created by Joey Damico on 7/5/20.
//  Copyright © 2020 Joey Damico. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "TripsData")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }

        return container
    }()
    
    @discardableResult
    func createTrip(date: Date, locationStart: String, locationEnd: String, locationTurn: String, hoursPort: Float, hoursStarboard: Float, tripHoursPort: Float, tripHoursStarboard: Float, notes: String) -> TripData? {
        let context = persistentContainer.viewContext
        
        let newTrip = NSEntityDescription.insertNewObject(forEntityName: "TripData", into: context) as! TripData // NSManagedObject

        newTrip.date = date
        newTrip.locationStart = locationStart
        newTrip.locationEnd = locationEnd
        newTrip.locationTurn = locationTurn
        newTrip.hoursPort = hoursPort
        newTrip.hoursStarboard = hoursStarboard
        newTrip.tripHoursPort = tripHoursPort
        newTrip.tripHoursStarboard = tripHoursStarboard
        newTrip.notes = notes

        do {
            try context.save()
            return newTrip
        } catch let createError {
            print("Failed to create: \(createError)")
        }

        return nil
    }

    func fetchTrips() -> [TripData]? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<TripData>(entityName: "TripData")

        do {
            let trips = try context.fetch(fetchRequest)
            return trips
        } catch let fetchError {
            print("Failed to fetch companies: \(fetchError)")
        }

        return nil
    }

    func fetchTripsByDate() -> [TripData]? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<TripData>(entityName: "TripData")
        let sort = NSSortDescriptor(key: #keyPath(TripData.date), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        do {
            let trips = try context.fetch(fetchRequest)
            return trips
        } catch {
            print("Cannot fetch Expenses")
        }
        
        return nil
    }
    
    func fetchNewestTrip() -> [TripData]? {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<TripData>(entityName: "TripData")
        let sort = NSSortDescriptor(key: #keyPath(TripData.date), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.fetchLimit = 1
        do {
            let newestTrip = try context.fetch(fetchRequest)
            return newestTrip
        } catch {
            print("Cannot fetch Expenses")
        }
        
        return nil
    }
    
    func getTotalHoursPort() -> Float {
        let trips = self.fetchTrips()        
        var hours = Float(0.0)
        
        for trip in trips! {
            hours += trip.tripHoursPort
        }
        
        return hours
    }
    
    func getTotalHoursStarboard() -> Float {
        let trips = self.fetchTrips()
        var hours = Float(0.0)
        
        for trip in trips! {
            hours += trip.tripHoursStarboard
        }
        
        return hours
    }
    
    func deleteTrip(tripToDelete: TripData) {
        let context = persistentContainer.viewContext
        context.delete(tripToDelete)

        do {
            try context.save()
        } catch let saveError {
            print("Failed to delete: \(saveError)")
        }
    }
    
/*
    func fetchEmployee(withName name: String) -> Employee? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do {
            let employees = try context.fetch(fetchRequest)
            return employees.first
        } catch let fetchError {
            print("Failed to fetch: \(fetchError)")
        }

        return nil
    }

    func updateEmployee(employee: Employee) {
        let context = persistentContainer.viewContext

        do {
            try context.save()
        } catch let createError {
            print("Failed to update: \(createError)")
        }
    }

    func deleteEmployee(employee: Employee) {
        let context = persistentContainer.viewContext
        context.delete(employee)

        do {
            try context.save()
        } catch let saveError {
            print("Failed to delete: \(saveError)")
        }
    }
 */
}
