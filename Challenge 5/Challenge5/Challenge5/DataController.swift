//
//  DataController.swift
//  Challenge5
//
//  Created by Andrei Rybak on 26.07.22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    static let shared = DataController()
    
    let container = NSPersistentContainer(name: "Users")
    
    private init() {
        container.loadPersistentStores { descriptor, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
