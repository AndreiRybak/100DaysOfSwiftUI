//
//  Prospect.swift
//  HotProspects
//
//  Created by Andrei Rybak on 1.08.22.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    enum FilterOptions {
        case name, email
    }
    
    @Published private(set) var people: [Prospect]

    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedFile")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            people = []
        }
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }

    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func sort(by option: FilterOptions) {
        switch option {
        case .name:
            people = people.sorted(by: {$0.name < $1.name })
        case .email:
            people = people.sorted(by: {$0.emailAddress < $1.emailAddress })
        }
    }
}
