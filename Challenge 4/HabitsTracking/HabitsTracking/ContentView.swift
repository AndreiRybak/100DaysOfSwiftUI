//
//  ContentView.swift
//  HabitsTracking
//
//  Created by Andrei Rybak on 20.07.22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var activityList = ActivityList()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(activityList.activities) { activity in
                        NavigationLink {
                            ActivityDetailView(activityList: activityList, activity: activity)
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(activity.title)")
                                    .font(.system(size: 28).bold())
                                    .foregroundColor(.white)
                                Text("\(activity.description)")
                                    .font(.system(size: 20).italic())
                                    .foregroundColor(.white.opacity(0.8))
                                HStack {
                                    Text("Streak:")
                                        .font(.system(size: 20).bold().italic())
                                        .foregroundColor(.white.opacity(0.8))
                                    Text("\(activity.streak)")
                                        .font(.system(size: 20).bold())
                                        .foregroundColor(.white.opacity(0.8))
                                }
                            }
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                minHeight: 0,
                                maxHeight: .infinity,
                                alignment: .leading
                            )
                            .padding()
                            .background(Color(red: 59 / 255, green: 54 / 255, blue: 89 / 255))
                            .cornerRadius(20)
                        }
                    }
                }
                .padding()
                .cornerRadius(20)
                .background(.clear)
            }
            .navigationTitle("Habits Tracker")
            .preferredColorScheme(.dark)
            .background(Color(red: 31 / 255, green: 29 / 255, blue: 41 / 255))
            .toolbar {
                NavigationLink {
                    AddActivityView(activityList: activityList)
                } label: {
                   Image(systemName: "plus")
                }
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
