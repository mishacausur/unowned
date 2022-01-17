//
//  CDDataManager.swift
//  unowned
// swiftlint:disable all
//  Created by Misha Causur on 16.01.2022.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {
    }
    
    private(set) lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "EventDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()
    
    func save(_ model: EventModel, completion: @escaping () -> ()) {
        let event = CDEvent(entity: NSEntityDescription.entity(forEntityName: "CDEvent", in: backgroundContext)!, insertInto: backgroundContext)
        event.id = model.id
        event.disrcrptn = model.welcomeDescription
        event.name = model.name
        event.address = model.address
        event.startDate = ("\(model.startDate)")
        event.endDate = ("\(model.endDate)")
        for i in model.phoneNumbers {
            let number = CDPhoneNumber(entity: NSEntityDescription.entity(forEntityName: "CDPhoneNumber", in: backgroundContext)!, insertInto: backgroundContext)
            number.number = i.number
        }
        backgroundContext.perform { [weak self] in
            do {
                try self?.backgroundContext.save()
                completion()
            }
            catch let error {
                print("\(error.localizedDescription) THIS IS ERRRRRRRORRRRR")
            }
        }
    }
    
    func CDgetData() -> [CDEvent] {
        var events: [CDEvent] = []
        let fetch: NSFetchRequest<CDEvent> = CDEvent.fetchRequest()
//        fetch.includesSubentities = false
        do {
            events = try viewContext.fetch(fetch)
        } catch let error {
            print(error.localizedDescription)
        }
        return events
    }
    
    func CDgetPhoneNumbers(for event: CDEvent) -> [CDPhoneNumber] {
        let fetch: NSFetchRequest<CDPhoneNumber> = CDPhoneNumber.fetchRequest()
        let predicate = NSPredicate(format: "event == %@", event)
        fetch.predicate = predicate
        do {
            let item = try viewContext.fetch(fetch)
            print(item)
            return item
        } catch {
            fatalError()
        }
    }
    
    func saveContext () {
           let context = persistentContainer.viewContext
           if context.hasChanges {
               do {
                   try context.save()
               } catch {
                   
                   let nserror = error as NSError
                   fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
               }
           }
       }
}
