//
//  Activity.swift
//  HabitsTracking
//
//  Created by Andrei Rybak on 20.07.22.
//

import Foundation

struct Activity: Codable, Identifiable {
    var id = UUID()

    let title: String
    let description: String
    let streak: Int
}

class ActivityList: ObservableObject {
    private let activitesKey = "Activites"

    @Published private(set) var activities = [Activity]()

    init() {
        loadActivities()
    }

    func add(activity: Activity) {
        if let existingItemIndex = activities.firstIndex(where: {$0.id == activity.id}) {
            activities.remove(at: existingItemIndex)
            activities.insert(activity, at: existingItemIndex)
        } else {
            activities.insert(activity, at: 0)
        }
        saveActivites()
    }

    func remove(activity: Activity) {
        activities.removeAll(where: {$0.id == activity.id})
        saveActivites()
    }

    private func saveActivites() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(activities) {
            UserDefaults.standard.set(encodedData, forKey: activitesKey)
        } else {
            fatalError("Can't read the data from user defaults")
        }
    }
    
    private func loadActivities() {
        guard let savedActivities = UserDefaults.standard.value(forKey: activitesKey) as? Data else {
            return
        }
        
        let decoder = JSONDecoder()
        if let decodedActivities = try? decoder.decode([Activity].self, from: savedActivities) {
            activities = decodedActivities
        } else {
            fatalError("Can't decode activities")
        }
    }
}
