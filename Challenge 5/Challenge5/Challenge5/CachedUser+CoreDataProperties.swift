//
//  CachedUser+CoreDataProperties.swift
//  Challenge5
//
//  Created by Andrei Rybak on 26.07.22.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var registered: String?
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?

    
    var wrappedName: String {
        return name ?? "Unknown"
    }
    
    var wrappedAge: Int {
        return Int(age)
    }
    
    var wrappedRegistered: Date {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let registeredDate = registered ?? ""
        let date = try? decoder.decode(Date.self, from: registeredDate.data(using: .utf8) ?? Data())
        return date ?? Date.now
    }
    
    var wrappedCompany: String {
        return company ?? "Unknown"
    }
    
    var wrappedAddress: String {
        return address ?? "Unknown"
    }
    
    var wrappedEmail: String {
        return email ?? "Unknown"
    }
    
    var wrappedAbout: String {
        return about ?? "Unknown"
    }
    
    var wrappedTags: [String] {
        return tags?.components(separatedBy: ",") ?? []
    }
    
    public var friendsArray: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
