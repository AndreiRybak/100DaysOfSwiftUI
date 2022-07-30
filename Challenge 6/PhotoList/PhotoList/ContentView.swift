//
//  ContentView.swift
//  PhotoList
//
//  Created by Andrei Rybak on 30.07.22.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedImage: UIImage?
    @State private var selectedConvertedImage: Image?

    var body: some View {
        NavigationView {
            Group {
                Text("TEST")
            }
            .toolbar {
                NavigationLink {
                   PhotoCreatorView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
