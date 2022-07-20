//
//  AddActivityView.swift
//  HabitsTracking
//
//  Created by Andrei Rybak on 20.07.22.
//

import SwiftUI

struct AddActivityView: View {

    @ObservedObject var activityList: ActivityList

    @State private var title: String = ""
    @State private var description: String = ""
    @State private var streak: Int = 0
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            
            HStack() {
                Text("Add new habbit")
                    .foregroundColor(.white)
                    .font(.system(size: 24, weight: .heavy, design: .default))
                
                Spacer()
            }
            .padding([.leading, .trailing])

            VStack {
                VStack(spacing: 20) {
                    TextField("Title", text: $title)
                        .frame(height: 34)
                        .background(Color(red: 33 / 255, green: 29 / 255, blue: 54 / 255))
                        .cornerRadius(4)
                        .accentColor(.white)
                    TextField("Description", text: $description)
                        .frame(height: 34)
                        .background(Color(red: 33 / 255, green: 29 / 255, blue: 54 / 255))
                        .cornerRadius(4)
                        .accentColor(.white)
                    Stepper("Your streak: \(streak)", value: $streak, in: 0...Int.max)
                        .foregroundColor(.white)
                }
                .padding()
            }
            .background(Color(red: 59 / 255, green: 54 / 255, blue: 89 / 255))
            .cornerRadius(20)
            .padding([.bottom, .leading, .trailing])
        }
        .background(Color(red: 31 / 255, green: 29 / 255, blue: 41 / 255))
        .toolbar {
            Button("Save") {
                activityList.add(activity: Activity(title: title, description: description, streak: streak))
                dismiss()
            }
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activityList: ActivityList())
    }
}
