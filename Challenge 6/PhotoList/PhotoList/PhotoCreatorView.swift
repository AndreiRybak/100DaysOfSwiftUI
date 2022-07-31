//
//  PhotoCreatorView.swift
//  PhotoList
//
//  Created by Andrei Rybak on 30.07.22.
//

import SwiftUI

struct PhotoCreatorView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: ViewModel

    init(photosContainer: PhotosContainer) {
        self._viewModel = StateObject(wrappedValue: ViewModel(photosContainer))
    }

    var body: some View {
        VStack(spacing: 16) {
            viewModel.image?
                .resizable()
                .scaledToFit()

            if viewModel.selectedImage != nil {
                VStack {
                    TextField("Title", text: $viewModel.title)
                    TextField("Description", text: $viewModel.description)
                }
            }

            Button {
                viewModel.showingPhotoPicker = true
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
        .sheet(isPresented: $viewModel.showingPhotoPicker) {
            PhotoPicker(image: $viewModel.selectedImage)
        }
        .toolbar {
            Button("Save") {
                guard let selectedImage = viewModel.selectedImage else {
                    return
                }
                let photo = Photo(image: selectedImage, title: viewModel.title, description: viewModel.description)
                viewModel.photosContainer.add(photo: photo)
                dismiss()
            }
            .disabled(!viewModel.isReadyToSave)
        }
    }
}

struct PhotoCreatorView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCreatorView(photosContainer: PhotosContainer())
    }
}
