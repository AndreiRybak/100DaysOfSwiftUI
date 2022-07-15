//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Andrei Rybak on 13.07.22.
//

import SwiftUI

struct FlagImage: View {
    let imageName: String

    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var restarTheGame = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score: Int = 0
    
    @State private var isFlageSelected = false
    @State private var selectedFlag = 0
    @State private var animationDegreesAmount = 0.0
    @State private var scaleAmount = 1.0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Select the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
        
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            isFlageSelected = true
                            selectedFlag = number
                            withAnimation {
                                animationDegreesAmount += 360
                            }
                        } label: {
                            FlagImage(imageName: countries[number])
                        }
                        .rotation3DEffect(
                            .degrees(number == selectedFlag ? animationDegreesAmount : 0), axis: (x: 0, y: 1, z: 0)
                        )
                        .opacity(number != correctAnswer && isFlageSelected ? 0.25 : 1)
                        .animation(nil, value: isFlageSelected)
                        .scaleEffect(number != correctAnswer && isFlageSelected ? 0.75 : 1)
                        .animation(.default, value: isFlageSelected)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score \(score)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue") {
                askQuestion()
            }
        } message: {
            Text("Your score is \(score)")
        }
        .alert("You win!", isPresented: $restarTheGame) {
            Button("Restart the game") {
                restartTheGame()
            }
        } message: {
            Text("You give the 8 correct answers in a row!")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            score = 0
        }
        
        if score == 8 {
            restarTheGame = true
        } else {
            showingScore = true
        }
        scaleAmount = 1.2
    }
    
    func askQuestion() {
        isFlageSelected = false
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restartTheGame() {
        score = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
