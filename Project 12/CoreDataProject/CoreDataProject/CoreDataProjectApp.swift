//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Andrei Rybak on 24.07.22.
//

import CoreData
import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
