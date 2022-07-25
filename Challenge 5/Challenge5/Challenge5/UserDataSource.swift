//
//  UserDataSource.swift
//  Challenge5
//
//  Created by Andrei Rybak on 25.07.22.
//

import Foundation

class UserDataSource: ObservableObject {
    @Published var users = [User]()
    
    init() {
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
            decoder.dateDecodingStrategy = .iso8601
            if let users = try? decoder.decode([User].self, from: data) {
                DispatchQueue.main.async {
                    self.users = users
                }
            } else {
                print("Failed to decode data")
            }

        } catch let error {
            print("Failed to download users: \(error.localizedDescription)")
        }
    }
}
