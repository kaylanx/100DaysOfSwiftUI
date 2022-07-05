//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Andy Kayley on 04/07/2022.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?

    var unwrappedName: String { name ?? "Unknown Candy" }

}

extension Candy : Identifiable {

}
