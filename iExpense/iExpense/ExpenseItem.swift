//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Andy Kayley on 05/05/2022.
//

import Foundation

struct ExpenseItem: Identifiable, Equatable, Codable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double

    var isPersonal: Bool {
        switch type {
            case .personal:
                return true
            case .business:
                return false
        }
    }

    var isBusiness: Bool {
        !isPersonal
    }
}

enum ExpenseType: String, CaseIterable, Codable {
    case personal = "Personal"
    case business = "Business"
}
