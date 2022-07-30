//
//  Photo.swift
//  PhotoList
//
//  Created by Andrei Rybak on 30.07.22.
//

import Foundation
import UIKit

struct Photo: Codable {
    enum CodingKeys: CodingKey {
        case image, title, description
    }

    var image: UIImage
    var title: String
    var description: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let imageData = try container.decode(Data.self, forKey: .image)
        image = UIImage(data: imageData) ?? UIImage()
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let imageData = image.jpegData(compressionQuality: 1.0)
        try container.encode(imageData, forKey: .image)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
    }
}
