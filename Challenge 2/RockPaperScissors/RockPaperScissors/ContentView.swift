//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Andrei Rybak on 13.07.22.
//

import SwiftUI

struct AIOptionText: View {
    let option: ContentView.Option

    var body: some View {
        HStack(spacing: 8) {
            Image(option: option)
                .font(.system(size: 40))
            Text(option.rawValue.capitalized)
                .font(.system(size: 60))
        }
    }
}

struct OptionButton: View {
    let option: ContentView.Option
    let action: (ContentView.Option) -> Void
    
    var body: some View {
        Button() {
            action(option)
        } label: {
            Image(option: option)
            Text(option.rawValue.capitalized)
        }
        .padding()
        .font(.title)
        .foregroundColor(.black)
        .frame(minWidth: 250, maxWidth: .infinity, maxHeight: 90, alignment: .center)
        .background(LinearGradient(colors: [.yellow, .blue], startPoint: .leading, endPoint: .trailing)
            .ignoresSafeArea())
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

extension Image {
    init(option: ContentView.Option) {
        switch option {
        case .rock:
            self.init(systemName: "stop.fill")
        case .paper:
            self.init(systemName: "hand.wave.fill")
        case .scissors:
            self.init(systemName: "scissors")
        }
    }
}

struct ContentView: View {
    enum Option: String {
        case rock
        case paper
        case scissors
    }
    
    private let options: [Option] = [.rock, .paper, .scissors]

    @State private var aiOption: Option
    @State private var isWinExpected: Bool = Bool.random()
    @State private var isEndGameAlertShown: Bool = false
    @State private var scores: Int = 0
    private let scoresToWin = 8
    
    init() {
        aiOption = options.randomElement() ?? .rock
    }
    
    var body: some View {
        ZStack {

            LinearGradient(colors: [.yellow, .blue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                VStack {
                    AIOptionText(option: aiOption)
                        .padding(.bottom, 24)
                    Text("You need to:")
                        .font(.title)
                    Text(isWinExpected ? "Win": "Lose")
                        .font(.system(size: 40).bold())
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                VStack(spacing: 8) {
                    OptionButton(option: .rock) { option in
                        checkAnswer(aiOption: aiOption, answer: option, isWinExpected: isWinExpected)
                    }
                    OptionButton(option: .paper) { option in
                        checkAnswer(aiOption: aiOption, answer: option, isWinExpected: isWinExpected)
                    }
                    OptionButton(option: .scissors) { option in
                        checkAnswer(aiOption: aiOption, answer: option, isWinExpected: isWinExpected)
                    }
                }
                .padding(20)
                .background(.ultraThinMaterial)
                .cornerRadius(16)
                
                Text("Scores: \(scores)")
                    .padding([.top], 30)
                    .font(.title)
            }
            .padding()
        }
        .alert("You win!", isPresented: $isEndGameAlertShown) {
            Button("Restart the game") {
                scores = 0
                randomAIOption()
            }
        } message: {
            Text("Try again?")
        }
    }
    
    private func checkAnswer(aiOption: Option, answer: Option, isWinExpected: Bool) {
       
        var isUserWin = false
        
        switch aiOption {
        case .rock:
            if isWinExpected {
                isUserWin = answer == .paper ? true : false
            } else {
                isUserWin = answer == .scissors ? true : false
            }
        case .paper:
            if isWinExpected {
                isUserWin = answer == .scissors ? true : false
            } else {
                isUserWin = answer == .rock ? true : false
            }
        case .scissors:
            if isWinExpected {
                isUserWin = answer == .rock ? true : false
            } else {
                isUserWin = answer == .paper ? true : false
            }
        }
        
        if isUserWin {
            scores += 1
        } else {
            scores -= 1
        }

        if scores == scoresToWin {
            isEndGameAlertShown = true
        }
        
        randomAIOption()
    }
    
    private func randomAIOption() {
        aiOption = options.randomElement() ?? .rock
        isWinExpected = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
