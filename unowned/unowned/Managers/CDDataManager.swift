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
    
    func save(_ model: EventModel, completion: @escaping (Bool) -> ()) {
        if !CDisEventExist(model) {
            let event = CDEvent(entity: NSEntityDescription.entity(forEntityName: "CDEvent", in: backgroundContext)!, insertInto: backgroundContext)
            event.identify = model.id
            event.disrcrptn = model.welcomeDescription
            event.category = model.category.name
            event.name = model.name
            event.address = model.address
            event.startDate = ("\(model.startDate)")
            event.endDate = ("\(model.endDate)")
            for i in model.phoneNumbers {
                let number = CDPhoneNumber(entity: NSEntityDescription.entity(forEntityName: "CDPhoneNumber", in: backgroundContext)!, insertInto: backgroundContext)
                number.number = i.number
                number.uuid = model.id
            }
        }
        backgroundContext.perform { [weak self] in
            do {
                try self?.backgroundContext.save()
                completion(true)
            }
            catch let error {
                print("\(error.localizedDescription) THIS IS ERRRRRRRORRRRR")
            }
        }
        completion(true)
    }
    
    func saveCategories(_ category: CategoryAPI, completion: @escaping (Bool) -> ()) {
        if !CDgetCategories(category) {
            let CDcategory = CDCategoryName(entity: NSEntityDescription.entity(forEntityName: "CDCategoryName", in: backgroundContext)!, insertInto: backgroundContext)
            CDcategory.name = category.name
            backgroundContext.perform { [weak self] in
                do {
                    try self?.backgroundContext.save()
                    completion(true)
                }
                catch let error {
                    print("\(error.localizedDescription) THIS IS EWW")
                }
            }
        }
        completion(true)
    }
    
    func CDisEventExist(_ category: EventModel) -> Bool {
        let fetch: NSFetchRequest<CDEvent> = CDEvent.fetchRequest()
        let id = category.id
        let predicate = NSPredicate(format: "%K == %@", #keyPath(CDEvent.identify), id)
        fetch.predicate = predicate
        var result: [NSManagedObject] = []
        do {
            result = try backgroundContext.fetch(fetch)
        } catch {
            fatalError()
        }
        return result.count > 0
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
    
    func CDgetPhoneNumbers(for id: String) -> [CDPhoneNumber] {
        let fetch: NSFetchRequest<CDPhoneNumber> = CDPhoneNumber.fetchRequest()
        fetch.fetchBatchSize = 1
//        let predicate = NSPredicate(format: "event  == %@", event)
        let predicate = NSPredicate(format: "%K == %@", #keyPath(CDPhoneNumber.uuid), id)
        fetch.predicate = predicate
        do {
            let item = try backgroundContext.fetch(fetch)
            return item
        } catch {
            fatalError()
        }
    }
    
    func CDgetCategories(_ category: CategoryAPI) -> Bool {
        let fetch: NSFetchRequest<CDCategoryName> = CDCategoryName.fetchRequest()
        let name = category.name
        let predicate = NSPredicate(format: "%K == %@", #keyPath(CDCategoryName.name), name)
        fetch.predicate = predicate
        var result: [NSManagedObject] = []
        do {
            result = try backgroundContext.fetch(fetch)
        } catch {
            fatalError()
        }
        return result.count > 0
    }
    
    func CDgetCategoriesForData() -> [CDCategoryName] {
        let fetch: NSFetchRequest<CDCategoryName> = CDCategoryName.fetchRequest()
//        fetch.fetchBatchSize = 1
//        let predicate = NSPredicate(format: "event  == %@", event)
//        let predicate = NSPredicate(format: "%K == %@", #keyPath(CDPhoneNumber.uuid), id)
//        fetch.predicate = predicate
        do {
            let item = try backgroundContext.fetch(fetch)
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
