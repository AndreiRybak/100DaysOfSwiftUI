//
//  PhotoCreatorView-ViewModel.swift
//  PhotoList
//
//  Created by Andrei Rybak on 30.07.22.
//

import Foundation
import UIKit
import SwiftUI
import CoreLocation

extension PhotoCreatorView {
    @MainActor class ViewModel: ObservableObject {

        @Published var showingPhotoPicker = false
        @Published var selectedImage: UIImage? {
            didSet {
                guard let selectedImage = selectedImage else {
                    return
                }
                Task { @MainActor in
                    image = Image(uiImage: selectedImage)
                }
            }
        }
        
        @Published var image: Image?
        
        @Published var title = ""
        @Published var description = ""
        
        @Published var latitude: Double?
        @Published var longitude: Double?

        var isReadyToSave: Bool {
            if selectedImage != nil && !title.isEmpty && !description.isEmpty {
                return true
            } else {
                return false
            }
        }

        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPhotos")
        
        @ObservedObject var photosContainer: PhotosContainer

        init(_ photosContainer: PhotosContainer) {
            self._photosContainer = ObservedObject(wrappedValue: photosContainer)
        }
        
        func savePhoto() {
            guard let selectedImage = selectedImage else {
                return
            }

            let photo = Photo(image: selectedImage, title: title, description: description)
            photosContainer.add(photo: photo)
        }
    }
}
