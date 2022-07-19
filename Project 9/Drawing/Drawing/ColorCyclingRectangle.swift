//
//  ColorCyclingRectangle.swift
//  Drawing
//
//  Created by Andrei Rybak on 19.07.22.
//

import SwiftUI


struct ColorCyclingRectangleView: View {
    var amount = 0.0
    
    var gradientStartX: CGFloat
    var gradientStartY: CGFloat
    var gradientEndX: CGFloat
    var gradientEndY: CGFloat

    var body: some View {
            ZStack {
                ForEach(0..<100) { value in
                    Rectangle()
                        .inset(by: Double(value))
                        .strokeBorder(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    color(for: value, brightness: 1),
                                    color(for: value, brightness: 1)
                                ]),
                                startPoint: UnitPoint(x: gradientStartX, y: gradientStartY),
                                endPoint: UnitPoint(x: gradientEndX, y: gradientEndY)
                            ),
                            lineWidth: 2
                        )
                }
            }
            .drawingGroup()
        }
    
    func color(for value: Int, brightness: Double) -> Color {
           var targetHue = Double(value) / Double(100) + amount

           if targetHue > 1 {
               targetHue -= 1
           }

           return Color(hue: targetHue, saturation: 1, brightness: brightness)
       }
}

struct ColorCyclingRectangleContentView: View {
    @State private var colorCycle = 0.0
    
    @State private var gradientStartX: CGFloat = 0.0
    @State private var gradientStartY: CGFloat = 0.0
    @State private var gradientEndX: CGFloat = 0.0
    @State private var gradientEndY: CGFloat = 0.0

    var body: some View {
        VStack {
            ColorCyclingRectangleView(
                amount: colorCycle,
                gradientStartX: gradientStartX,
                gradientStartY: gradientStartY,
                gradientEndX: gradientEndX,
                gradientEndY: gradientEndY
            )
            .frame(width: 300, height: 300)

            Slider(value: $colorCycle)
            
            Text("Gradient start point")
                .padding(.top)
                .font(.headline)
            HStack {
                Text("x")
                Slider(value: $gradientStartX, in: 0...1)
            }
            HStack {
                Text("y")
                Slider(value: $gradientStartY, in: 0...1)
            }
            
            Text("Gradient end point")
                .padding(.top)
                .font(.headline)
            HStack {
                Text("x")
                Slider(value: $gradientEndX, in: 0...1)
            }
            
            HStack {
                Text("y")
                Slider(value: $gradientEndY, in: 0...1)
            }
            
        }
        .padding()
    }
}

struct ColorCyclingRectangleContentView_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingRectangleContentView()
    }
}
