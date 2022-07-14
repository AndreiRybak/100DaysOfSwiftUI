//
//  ContentView.swift
//  BetterRest
//
//  Created by Andrei Rybak on 14.07.22.
//

import CoreML
import SwiftUI

struct ContentView: View {

    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var cofeeAmount = 0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    @State private var predictedSleepTime = Date.now
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                } header: {
                    Text("When do you want to wake up?")
                        .font(.headline)
                }
                
                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("Desired amount of sleep")
                        .font(.headline)
                }
                
                Section {
                    Picker((cofeeAmount + 1) == 1 ? "\(cofeeAmount + 1) cup" : "\(cofeeAmount + 1) cups", selection: $cofeeAmount) {
                        ForEach(1..<21) { index in
                            Text(index == 1 ? "1 cup" : "\(index) cups")
                        }
                    }
                } header: {
                    Text("Daily cofee intake")
                        .font(.headline)
                }
                
                VStack {
                    HStack {
                        Text("Your ideal bedtime is:")
                        Text(predictedSleepTime.formatted(date: .omitted, time: .shortened))
                            .bold()
                            .font(.title3)
                    }
                }
            }
            .navigationTitle("BetterRest")
            .onChange(of: wakeUp) { _ in
                calculateBadTime()
            }
            .onChange(of: sleepAmount) { _ in
                calculateBadTime()
            }
            .onChange(of: cofeeAmount) { _ in
                calculateBadTime()
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("Try again") { }
            } message: {
                Text(alertMessage)
            }
        }
    }

    func calculateBadTime() {
        do {
            let config =  MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(cofeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            predictedSleepTime = sleepTime
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculation you bedtime."
            showingAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
