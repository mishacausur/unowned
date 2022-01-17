//
//  CDCategoryName+CoreDataProperties.swift
//  unowned
//
//  Created by Misha Causur on 17.01.2022.
//
//

import Foundation
import CoreData


extension CDCategoryName {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCategoryName> {
        return NSFetchRequest<CDCategoryName>(entityName: "CDCategoryName")
    }

    @NSManaged public var name: String?

}

extension CDCategoryName : Identifiable {

}
