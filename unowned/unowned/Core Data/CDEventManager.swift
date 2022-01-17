//
//  CDEventManager.swift
//  unowned
//
//  Created by Misha Causur on 16.01.2022.
//

//import CoreData
//
//@objc(CDEvent)
//public class CDEvent: NSManagedObject {
//    
//}
//
//extension CDEvent {
//
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEvent> {
//        return NSFetchRequest<CDEvent>(entityName: "CDEvent")
//    }
//
//    @NSManaged public var address: String?
//    @NSManaged public var disrcrptn: String?
//    @NSManaged public var endDate: String?
//    @NSManaged public var id: String?
//    @NSManaged public var name: String?
//    @NSManaged public var startDate: String?
//    @NSManaged public var category: String?
//    @NSManaged public var phoneNumbers: NSSet?
//
//}
//
//// MARK: Generated accessors for phoneNumbers
//extension CDEvent {
//
//    @objc(addPhoneNumbersObject:)
//    @NSManaged public func addToPhoneNumbers(_ value: CDPhoneNumber)
//
//    @objc(removePhoneNumbersObject:)
//    @NSManaged public func removeFromPhoneNumbers(_ value: CDPhoneNumber)
//
//    @objc(addPhoneNumbers:)
//    @NSManaged public func addToPhoneNumbers(_ values: NSSet)
//
//    @objc(removePhoneNumbers:)
//    @NSManaged public func removeFromPhoneNumbers(_ values: NSSet)
//
//}
//
//extension CDEvent : Identifiable {
//
//}
