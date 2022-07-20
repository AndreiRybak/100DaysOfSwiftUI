//
//  ActivityDetailView.swift
//  HabitsTracking
//
//  Created by Andrei Rybak on 20.07.22.
//

import SwiftUI

struct ActivityDetailView: View {
    private(set) var activityList: ActivityList
    private(set) var activity: Activity

    @State private var streak: Int = 0
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(activity.title)")
                        .font(.system(size: 28).bold())
                        .foregroundColor(.white)
                    Text("\(activity.description)")
                        .font(.system(size: 20).italic())
                        .foregroundColor(.white.opacity(0.8))
                    Stepper("Your streak: \(streak)", value: $streak, in: 0...Int.max)
                        .foregroundColor(.white)
                }
                .padding()
            }
            .background(Color(red: 59 / 255, green: 54 / 255, blue: 89 / 255))
            .cornerRadius(20)
            .padding([.bottom, .leading, .trailing])
            
            Button("Delete", role: .destructive) {
                activityList.remove(activity: activity)
            }
            .buttonStyle(.borderedProminent)
        }
        .background(Color(red: 31 / 255, green: 29 / 255, blue: 41 / 255))
        .onAppear {
            streak = activity.streak
        }
        .onChange(of: streak) { newValue in
            if activity.streak != newValue {
                let updatedActivity = Activity(id: activity.id, title: activity.title, description: activity.description, streak: streak)
                activityList.add(activity: updatedActivity)
            }
        }
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activityList: ActivityList(), activity: Activity(title: "123", description: "321", streak: 10))
    }
}
