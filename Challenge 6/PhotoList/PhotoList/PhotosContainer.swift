//
//  PhotosContainer.swift
//  PhotoList
//
//  Created by Andrei Rybak on 31.07.22.
//

import Foundation

class PhotosContainer: ObservableObject {
    @Published private(set) var photos = [Photo]()
    
    private let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPhotos")
    
    init() {
        do {
            let data = try Data(contentsOf: self.savePath)
            let decodedPhotos = try JSONDecoder().decode([Photo].self, from: data)
            self.photos = decodedPhotos

        } catch {
            self.photos = []
        }
    }

    func add(photo: Photo) {
        photos.append(photo)
        save()
    }
    
    func removePhoto(at offsets: IndexSet) {
        photos.remove(atOffsets: offsets)
        save()
    }

    private func save() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            do {
                let data = try JSONEncoder().encode(self.photos)
                try data.write(to: self.savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        }
    }
}
