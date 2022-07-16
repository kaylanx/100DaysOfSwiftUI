//
//  CachedFriend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Andy Kayley on 16/07/2022.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: CachedUser?

}

extension CachedFriend : Identifiable {

}
