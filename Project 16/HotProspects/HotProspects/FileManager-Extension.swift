//
//  FileManager-Extension.swift
//  HotProspects
//
//  Created by Andrei Rybak on 1.08.22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
