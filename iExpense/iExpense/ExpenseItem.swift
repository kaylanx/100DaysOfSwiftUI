//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Andy Kayley on 05/05/2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
