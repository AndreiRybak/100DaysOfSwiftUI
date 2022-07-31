//
//  Photo.swift
//  PhotoList
//
//  Created by Andrei Rybak on 30.07.22.
//

import Foundation
import UIKit
import CoreLocation

struct Photo: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case image, title, description, latitude, longitude
    }
    
    var id = UUID()
    var image: UIImage
    var title: String
    var description: String
    var latitude: Double?
    var longitude: Double?
    
    var coordinate: CLLocationCoordinate2D? {
        guard let latitude = latitude, let longitude = longitude else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(image: UIImage, title: String, description: String, latitude: Double? = nil, longitude: Double? = nil) {
        self.image = image
        self.title = title
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let imageData = try container.decode(Data.self, forKey: .image)
        image = UIImage(data: imageData) ?? UIImage()
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let imageData = image.jpegData(compressionQuality: 1.0)
        try container.encode(imageData, forKey: .image)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
}
