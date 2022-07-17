//
//  ExpenseItem.swift
//  iExpence
//
//  Created by Andrei Rybak on 17.07.22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
