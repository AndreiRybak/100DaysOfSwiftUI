//
//  ContentView.swift
//  EdutainmentApp
//
//  Created by Andrei Rybak on 16.07.22.
//

import SwiftUI


struct StartGameNavigationLink: View {
    let gameParameters: GameView.GameParameters
    
    var body: some View {
        NavigationLink(destination: GameView(gameParameters: gameParameters)) {
           Text("Start game")
        }
        .frame(width: 190, height: 60, alignment: .center)
        .background(LinearGradient(colors: [.red, .gray, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
        .foregroundColor(.black)
        .cornerRadius(8)
    }
}

struct ContentView: View {
    @State private var multiplication = 2
    
    @State private var numberOfQuestions = 10
    private let possibleNumberOfQuestion = [5, 10, 20, 30]
    
    private let keyboardSpacing = 8
    private var buttonSize: CGSize {
        let screenSize = UIScreen.main.bounds.width
        let buttonSize = (screenSize / 3.0) - CGFloat((keyboardSpacing * 4))
        return CGSize(width: buttonSize, height: buttonSize)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.yellow, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                
                VStack(alignment: .center, spacing: 24) {
                    
                    VStack(alignment: .leading) {
                        Section {
                            Stepper("Up to \(multiplication)", value: $multiplication, in: 2...12)
                        } header: {
                            Text("Select multiplication tables you want to practice.")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                    }
                    .padding([.top], 86)
                    
                    
                    VStack(alignment: .leading) {
                        Section {
                            Picker("Select number of question", selection: $numberOfQuestions) {
                                ForEach(possibleNumberOfQuestion, id: \.self) { option in
                                    Text("\(option)")
                                }
                            }
                            .pickerStyle(.segmented)
                        } header: {
                            Text("Select how many questions you want to be asked.")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                    }
                    .padding([.top], 32)
                    
                    
                    Spacer()
                    
                    StartGameNavigationLink(gameParameters: GameView.GameParameters(multiplication: multiplication, numberOfQuestions: numberOfQuestions))
                        .padding([.bottom], 40)
                }
                .padding()
                .padding([.top], 40)
            }
            .navigationTitle("Game settings")
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
