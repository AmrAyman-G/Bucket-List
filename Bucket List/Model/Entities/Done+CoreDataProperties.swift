//
//  Done+CoreDataProperties.swift
//  
//
//  Created by amr on 07/06/2022.
//
//

import Foundation
import CoreData


extension Done {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Done> {
        return NSFetchRequest<Done>(entityName: "Done")
    }

    @NSManaged public var name: String?
    @NSManaged public var time: Date?
    @NSManaged public var color: String?

}
