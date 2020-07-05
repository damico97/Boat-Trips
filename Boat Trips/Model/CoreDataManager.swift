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
    func createTrip(locationStart: String, locationEnd: String) -> Trip? {
        let context = persistentContainer.viewContext
        
        let newTrip = NSEntityDescription.insertNewObject(forEntityName: "Test1", into: context) as! Trip // NSManagedObject

        //newTrip.date = date
        newTrip.locationStart = locationStart
        newTrip.locationEnd = locationEnd
        //newTrip.hoursPort = hoursPort
        //newTrip.hoursStarboard = hoursStarboard

        do {
            try context.save()
            return newTrip
        } catch let createError {
            print("Failed to create: \(createError)")
        }

        return nil
    }

    func fetchTrips() -> [Trip]? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Trip>(entityName: "Test1")

        do {
            let trips = try context.fetch(fetchRequest)
            return trips
        } catch let fetchError {
            print("Failed to fetch companies: \(fetchError)")
        }

        return nil
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
