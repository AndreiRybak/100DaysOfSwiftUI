//
//  Card.swift
//  Flashzilla
//
//  Created by Andrei Rybak on 2.08.22.
//

import Foundation

struct Card: Codable, Identifiable {
    var id = UUID()
    
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Who played the 13th doctor in Doctor Who?", answer: "Jodie Whittaker")
}
