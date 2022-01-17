//
//  CDPhoneNumber+CoreDataProperties.swift
//  unowned
//
//  Created by Misha Causur on 16.01.2022.
//
//

import Foundation
import CoreData

extension CDPhoneNumber {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPhoneNumber> {
        return NSFetchRequest<CDPhoneNumber>(entityName: "CDPhoneNumber")
    }

    @NSManaged public var number: String?
    @NSManaged public var uuid: String
    @NSManaged public var event: CDEvent?

}
extension CDPhoneNumber: Identifiable {}
