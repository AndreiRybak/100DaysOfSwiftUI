//
//  CardView.swift
//  Flashzilla
//
//  Created by Andrei Rybak on 2.08.22.
//

import SwiftUI

extension Shape {
    func fillCardBackground(for offset: CGSize) -> some View {
        if offset.width > 0 {
            return self.fill(.green)
        } else if offset.width < 0 {
            return self.fill(.red)
        } else {
            return self.fill(.white)
        }
    }
}

struct CardView: View {
    let card: Card
    let removal: (() -> Void)?
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled

    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    @State private var feedback = UINotificationFeedbackGenerator()

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                    ? .white
                    : .white.opacity(1 - Double(abs(offset.width / 100)))
                )
                .background(
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fillCardBackground(for: offset)
                )
                .shadow(radius: 10)
               
            
            VStack {
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray )
                    }
                }
                
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 2.5, y: 0)
        .opacity(2 - Double(abs(offset.width / 100)))
        .accessibilityAddTraits([.isButton])
        .gesture (
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    feedback.prepare()
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        if offset.width < 0 {
                            feedback.notificationOccurred(.error)
                        }
                        removal?()
                    } else {
                        offset = .zero
                    }
                }
        )
         .onTapGesture {
            isShowingAnswer.toggle() 
        }
         .animation(.spring(), value: offset)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example, removal: nil )
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
