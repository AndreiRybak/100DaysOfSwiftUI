//
//  ContentView.swift
//  DiceRoll
//
//  Created by Andrei Rybak on 4.08.22.
//

import SwiftUI

struct RandomNumber: Identifiable {
    var id = UUID()
    var value: Int
    var index: Int
}

struct ContentView: View {
    private enum Dice: String {
        case four = "4"
        case six = "6"
        case eight = "8"
        case ten = "10"
        case twelve = "12"
        case twenty = "20"
        case hundred = "100"
        
        func description() -> String {
            return ""
        }
    }
    private let diceOptions: [Dice] = [.four, .six, .eight, .ten, .twelve, .twenty, .hundred]
    
    @State private var selectedDice = Dice.six
    @State private var xOffset: CGFloat = 0
    
    @State private var randomNumbers = [RandomNumber]()
    
    private var feedbackGenerator = UINotificationFeedbackGenerator()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Select the number of sides of the dice")
                        .font(.headline)
                    Picker(selectedDice.description(), selection: $selectedDice) {
                        ForEach(diceOptions, id: \.self) { dice in
                            Text(dice.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Spacer()
                ZStack {
                    Rectangle()
                        .fill(.white)
                        .cornerRadius(8)
                        .shadow(color: .gray, radius: 8)

                    
                    ForEach(randomNumbers) { randomNumber in
                        Text("\(randomNumber.value)")
                            .frame(width: 160, height: 160)
                            .font(.system(size: 72))
                            .offset(x: CGFloat(randomNumber.index * 160), y: 0)
                            .offset(x: xOffset, y: 0)
                            .clipped()
                    }
                }
                .frame(width: 160, height: 160)
                
                    
                Spacer()
                
                VStack {
                    Button("Roll") {
                        animateRoll()
                    }
                    .frame(width: 120, height: 42)
                    .background(.blue.opacity(0.8))
                    .foregroundColor(.white)
                    .font(.headline)
                    .clipShape(Capsule())
                }
            }
            .padding()
            .navigationTitle("DiceRoll")
        }
    }
    
    func randomElements() {
        randomNumbers.removeAll()
        for index in 0..<20 {
            let randomValue = Int.random(in: 1...(Int(selectedDice.rawValue) ?? 6))
            let randomNumber = RandomNumber(value: randomValue, index: index)
            randomNumbers.append(randomNumber)
        }
    }
    
    func animateRoll() {
        let animationDuration = 5.0
        
        randomElements()
        xOffset = 0.0
        withAnimation(Animation.easeOut(duration: animationDuration)) {
            print(randomNumbers)
            print(randomNumbers.count)
            xOffset = CGFloat(-160 * (randomNumbers.count - 1))
        }

        feedbackGenerator.prepare()
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            feedbackGenerator.notificationOccurred(.success)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
