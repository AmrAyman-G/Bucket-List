//
//  Users+CoreDataProperties.swift
//  
//
//  Created by amr on 12/06/2022.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var image: Data?
    @NSManaged public var delete: NSSet?
    @NSManaged public var done: NSSet?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for delete
extension Users {

    @objc(addDeleteObject:)
    @NSManaged public func addToDelete(_ value: Deleted)

    @objc(removeDeleteObject:)
    @NSManaged public func removeFromDelete(_ value: Deleted)

    @objc(addDelete:)
    @NSManaged public func addToDelete(_ values: NSSet)

    @objc(removeDelete:)
    @NSManaged public func removeFromDelete(_ values: NSSet)

}

// MARK: Generated accessors for done
extension Users {

    @objc(addDoneObject:)
    @NSManaged public func addToDone(_ value: Done)

    @objc(removeDoneObject:)
    @NSManaged public func removeFromDone(_ value: Done)

    @objc(addDone:)
    @NSManaged public func addToDone(_ values: NSSet)

    @objc(removeDone:)
    @NSManaged public func removeFromDone(_ values: NSSet)

}

// MARK: Generated accessors for items
extension Users {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: List)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: List)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
