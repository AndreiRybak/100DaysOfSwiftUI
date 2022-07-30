//
//  FileManager-Extension.swift
//  PhotoList
//
//  Created by Andrei Rybak on 30.07.22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
