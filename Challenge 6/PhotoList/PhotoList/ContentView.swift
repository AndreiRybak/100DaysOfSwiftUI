//
//  ContentView.swift
//  PhotoList
//
//  Created by Andrei Rybak on 30.07.22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var photosContainer = PhotosContainer()

    var body: some View {
        NavigationView {
            List {
                ForEach(photosContainer.photos) { photo in
                    HStack {
                        Image(uiImage: photo.image)
                            .resizable()
                            .frame(width: 140, height: 70)
                            .scaledToFit()
                        VStack(alignment: .leading) {
                            Text(photo.title)
                                .font(.headline)
                            Text(photo.description)
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: deletePhotos)
            }
            .toolbar {
                NavigationLink {
                    PhotoCreatorView(photosContainer: photosContainer)
                } label: {
                    Image(systemName: "plus")
                }
            }
            .navigationBarTitle("PhotoList")
        }
    }
    
    func deletePhotos(at offsets: IndexSet) {
        photosContainer.removePhoto(at: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
