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
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "unowned")
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
    
    func save(_ model: EventModel) {
        let event = CDEvent(context: backgroundContext)
        event.id = model.id
        event.disrcrptn = model.welcomeDescription
        event.name = model.name
        event.address = model.address
        event.startDate = ("\(model.startDate)")
        event.endDate = ("\(model.endDate)")
        for i in model.phoneNumbers {
            event.phoneNumbers.inse
        }
        event.phoneNumbers = numbers
        backgroundContext.perform { [weak self] in
            do {
                try self?.backgroundContext.save()
            }
            catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func CDgetData() -> [CDEvent] {
        let fetch: NSFetchRequest<CDEvent> = CDEvent.fetchRequest()
        do {
            return try viewContext.fetch(fetch)
        } catch {
            fatalError()
        }
    }
    
    func performData(_ CDEvents: [CDEvent]) -> [EventModel] {
        var events: [EventModel] = []
        for i in CDEvents {
            guard let id = i.id,
                  let name = i.name,
                  let address = i.address,
                  let descr = i.disrcrptn,
                  let startDate = i.startDate,
                  let endDate = i.endDate,
                  let phones = i.phoneNumbers
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
