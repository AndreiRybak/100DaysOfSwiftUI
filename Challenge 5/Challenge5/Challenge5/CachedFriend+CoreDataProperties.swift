//
//  CachedFriend+CoreDataProperties.swift
//  Challenge5
//
//  Created by Andrei Rybak on 26.07.22.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var user: NSSet?

    var wrappedName: String {
        return name ?? "Unknown"
    }
}

// MARK: Generated accessors for user
extension CachedFriend {

    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: CachedUser)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: CachedUser)

    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)

}

extension CachedFriend : Identifiable {

}
