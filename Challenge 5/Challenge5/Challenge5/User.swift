//
//  User.swift
//  Challenge5
//
//  Created by Andrei Rybak on 25.07.22.
//

import Foundation

struct Friend: Codable, Identifiable {
    var id: String
    var name: String
}

struct User: Codable, Identifiable {
    var id: String
    var isActive: Bool
    var registered: Date
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var tags: [String]
    var friends: [Friend]
}
