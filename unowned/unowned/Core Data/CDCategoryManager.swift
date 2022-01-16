//
//  CoreDataManager.swift
//  unowned
//
//  Created by Misha Causur on 16.01.2022.
//

import CoreData
import UIKit

@objc(CDCategoryName)
class CDCategoryName: NSManagedObject {
    
}

extension CDCategoryName {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCategoryName> {
        return NSFetchRequest<CDCategoryName>(entityName: "CDCategoryName")
    }

    @NSManaged public var name: String?

}

extension CDCategoryName : Identifiable {

}
