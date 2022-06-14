//
//  List+CoreDataProperties.swift
//  
//
//  Created by amr on 12/06/2022.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var color: String?
    @NSManaged public var name: String?
    @NSManaged public var time: Date?
    @NSManaged public var listSteps: NSSet?
    @NSManaged public var user: Users?

}

// MARK: Generated accessors for listSteps
extension List {

    @objc(addListStepsObject:)
    @NSManaged public func addToListSteps(_ value: Steps)

    @objc(removeListStepsObject:)
    @NSManaged public func removeFromListSteps(_ value: Steps)

    @objc(addListSteps:)
    @NSManaged public func addToListSteps(_ values: NSSet)

    @objc(removeListSteps:)
    @NSManaged public func removeFromListSteps(_ values: NSSet)

}
