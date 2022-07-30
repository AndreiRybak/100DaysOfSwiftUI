//
//  PhotoCreatorView.swift
//  PhotoList
//
//  Created by Andrei Rybak on 30.07.22.
//

import SwiftUI

struct PhotoCreatorView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var showingPhotoPicker = false
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    
    @State private var title = ""
    @State private var description = ""

    var body: some View {
        VStack(spacing: 16) {
            image?
                .resizable()
                .scaledToFit()

            if selectedImage != nil {
                VStack {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                }
            }

            Button {
                showingPhotoPicker = true
            } label: {
                Text("Select a photo")
                    .padding()
            }
            .frame(height: 44)
            .background(.blue)
            .clipShape(Capsule())
            .foregroundColor(.white)
            .font(.headline)
            .padding(.top, 24)
            
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showingPhotoPicker) {
            PhotoPicker(image: $selectedImage)
        }
        .onChange(of: selectedImage) { newValue in
            guard let newValue = newValue else {
                return
            }
            image = Image(uiImage: newValue)
        }
        .toolbar {
            Button("Save") {
                dismiss()
            }
        }
    }
}

struct PhotoCreatorView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCreatorView()
    }
}
