//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Andrei Rybak on 13.07.22.
//

import SwiftUI

struct LargeBlueFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func largeBlueFont() -> some View {
        modifier(LargeBlueFont())
    }
}

struct GridView<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content
    
    var body: some View {
        VStack(alignment: .center) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(alignment: .center) {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        GridView(rows: 4, columns: 4) { row, column in
            Image(systemName: "\(row * 4 + column).circle")
                .frame(width: 40, height: 40, alignment: .center)
            Text("\(row)\(column)")
                .largeBlueFont()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
