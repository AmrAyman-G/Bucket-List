//
//  Steps+CoreDataProperties.swift
//  
//
//  Created by amr on 02/06/2022.
//
//

import Foundation
import CoreData


extension Steps {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Steps> {
        return NSFetchRequest<Steps>(entityName: "Steps")
    }

    @NSManaged public var step: String?
    @NSManaged public var time: Date?
    @NSManaged public var list: List?

}
