//
//  GameView.swift
//  EdutainmentApp
//
//  Created by Andrei Rybak on 16.07.22.
//

import SwiftUI

struct KeyboardButton: View {
    let title: String
    let action: (String) -> Void

    private var buttonSize: CGSize {
        let screenSize = UIScreen.main.bounds.size
        let buttonSize = (screenSize.width / 3.0) - 16
        return CGSize(width: buttonSize, height: buttonSize)
    }
    
    var body: some View {
        Button(title) {
            action(title)
        }
        .frame(width: buttonSize.width, height: buttonSize.height, alignment: .center)
        .background(LinearGradient(colors: [.blue, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
        .foregroundColor(.black)
        .font(.title)
        .clipShape(Circle())
    }
}

struct KeyboardView: View {

    private let numberForKeyIndex = ["00": "1", "01": "2", "02": "3",
                                     "10": "4", "11": "5", "12": "6",
                                     "20": "7", "21": "8", "22": "9"]

    let result: (String) -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            ForEach(0..<4) { rowIndex in
                HStack(alignment: .center, spacing: 16) {
                    if rowIndex != 3 {
                        ForEach(0..<3) { columnIndex in
                            KeyboardButton(
                                title: numberForKeyIndex["\(rowIndex)\(columnIndex)"] ?? "0",
                                action: { buttonValue in
                                    result(buttonValue)
                                })
                        }
                    } else {
                        KeyboardButton(
                            title: "0",
                            action: { buttonValue in
                                result(buttonValue)
                            })
                    }
                }
            }
        }
    }
}

struct GameView: View {

    struct GameParameters {
        let multiplication: Int
        let numberOfQuestions: Int
    }
    
    let gameParameters: GameParameters
    
    private struct Question {
        let question: String
        let answer: String
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var questions = [Question]()
    @State private var askedQuestion = ""
    @State private var askedQuestionAnswer = ""
    
    @State private var userAnswer = " "
    @State private var correctAnswers = 0
    
    @State private var isGameFinished = false

    var body: some View {
        ZStack {
            
            LinearGradient(colors: [.red, .gray, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
            
            VStack(alignment: .center) {
                Spacer()
                Spacer()
                Text("\(askedQuestion) = ?")
                    .font(.system(size: 42, weight: .bold, design: .monospaced))
                Spacer()
                Text(userAnswer)
                    .font(.system(size: 52, weight: .bold, design: .monospaced))
                Spacer()
                KeyboardView() { result in
                    userAnswer = (userAnswer + result).trimmingCharacters(in: .whitespacesAndNewlines)
                }
                Spacer()
            }
        }
        .ignoresSafeArea()
        .onAppear {
            generateQuestions(with: gameParameters)
            askQuestion()
        }
        .onChange(of: userAnswer) { newValue in
            if newValue == askedQuestionAnswer {
                correctAnswers += 1
                askQuestion()
            } else {
                if newValue.count >= askedQuestionAnswer.count {
                    askQuestion()
                }
            }
        }
        .alert("The end!", isPresented: $isGameFinished) {
            Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
            }
        } message: {
            if correctAnswers == 1 {
                Text("You got a \(1) correct answer")
            } else {
                Text("You got a \(correctAnswers) correct answer")
            }
        }
    }
    
    private func generateQuestions(with: GameParameters) {
        while questions.count != gameParameters.numberOfQuestions {
            let firstNumber = Int.random(in: 2...9)
            let secondNumber = Int.random(in: 2...gameParameters.multiplication)
            let generatedQuestion = "\(firstNumber) * \(secondNumber)"

            let answer = String(firstNumber * secondNumber)
            let question = Question(question: generatedQuestion, answer: answer)
            questions.append(question)
        }
    }
    
    private func askQuestion() {
        guard !questions.isEmpty else {
            finishGame()
            return
        }

        let randomQuestion = questions.first ?? Question(question: "2 * 2", answer: "4")
        askedQuestion = randomQuestion.question
        askedQuestionAnswer = randomQuestion.answer
        questions.removeFirst()

        DispatchQueue.global().asyncAfter(deadline: .now() + 0.25) {
            userAnswer = " "
        }
    }
    
    private func finishGame() {
        isGameFinished = true
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameParameters: GameView.GameParameters(multiplication: 2, numberOfQuestions: 10))
    }
}
