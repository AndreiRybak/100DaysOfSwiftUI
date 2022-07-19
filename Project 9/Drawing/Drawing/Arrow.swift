//
//  Arrow.swift
//  Drawing
//
//  Created by Andrei Rybak on 19.07.22.
//

import SwiftUI

struct Arrow: Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.maxX, y: rect.midY))

        path.addLine(to: CGPoint(x: rect.maxX - rect.midY, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - rect.midY, y: rect.midY + (rect.midY / 3)))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY + (rect.midY / 3)))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY - (rect.midY / 3)))
        path.addLine(to: CGPoint(x: rect.maxX - rect.midY, y: rect.midY - (rect.midY / 3)))
        path.addLine(to: CGPoint(x: rect.maxX - rect.midY, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        
        path.closeSubpath()
        
        return path
    }
}

struct ArrowView: View {
    @State private var thickness = 1.0
    
    var body: some View {
        VStack {
            Spacer()

            Arrow()
                .stroke(.red, lineWidth: thickness)
                .frame(width: 300, height: 200)
            
            
            
            Spacer()

            Slider(value: $thickness, in: 1...40)
                .padding()
            
            Button("Make arrow thick") {
                withAnimation {
                    thickness = 40
                }
            }
            .padding()
            
            Spacer()
        }
        .frame(width: .infinity, height: .infinity)
        .ignoresSafeArea()
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}
