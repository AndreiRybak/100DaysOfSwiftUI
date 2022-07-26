//
//  Challenge5App.swift
//  Challenge5
//
//  Created by Andrei Rybak on 25.07.22.
//

import SwiftUI

@main
struct Challenge5App: App {
    @StateObject private var dataController = DataController.shared

    private let userLoader = UserDataLoader()
    
    init() {
        userLoader.fetchAndSaveUsers()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
