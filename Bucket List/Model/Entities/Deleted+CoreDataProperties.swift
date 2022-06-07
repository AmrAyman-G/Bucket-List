//
//  Deleted+CoreDataProperties.swift
//  
//
//  Created by amr on 07/06/2022.
//
//

import Foundation
import CoreData


extension Deleted {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Deleted> {
        return NSFetchRequest<Deleted>(entityName: "Deleted")
    }

    @NSManaged public var color: String?
    @NSManaged public var name: String?
    @NSManaged public var time: Date?

}
