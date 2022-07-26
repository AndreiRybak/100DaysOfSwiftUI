//
//  UserDataSource.swift
//  Challenge5
//
//  Created by Andrei Rybak on 25.07.22.
//

import Foundation
import CoreData

class UserDataLoader {
    private let moc = DataController.shared.container.viewContext
    private var users = [User]()

    private func saveUsers() {
        if !users.isEmpty {
            print(users.count)
            for user in users {
                let cachedUser = CachedUser(context: moc)
                cachedUser.id = user.id
                cachedUser.name = user.name
                cachedUser.age = user.age
                cachedUser.email = user.email
                cachedUser.address = user.address
                cachedUser.registered = user.registered
                cachedUser.about = user.about
                cachedUser.company = user.company
                cachedUser.isActive = user.isActive
                cachedUser.tags = user.tags.joined(separator: ",")
                
                for friend in user.friends {
                    let cachedFriend = CachedFriend(context: moc)
                    cachedFriend.id = friend.id
                    cachedFriend.name = friend.name
                    cachedFriend.addToUser(cachedUser)
                    cachedUser.addToFriends(cachedFriend)
                }
                
            }
            do {
                try moc.save()
            } catch let error {
                print("Failed to save: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchAndSaveUsers() {
        if users.isEmpty {
            Task {
                await fetchUsers()
            }
        }
    }
    
    private func fetchUsers() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()

            if let users = try? decoder.decode([User].self, from: data) {
                await MainActor.run {
                    self.users = users
                    saveUsers()
                }
            } else {
                print("Failed to decode data")
            }

        } catch let error {
            print("Failed to download users: \(error.localizedDescription)")
        }
    }
}
