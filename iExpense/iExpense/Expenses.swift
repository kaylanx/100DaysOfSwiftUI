//
//  Expenses.swift
//  iExpense
//
//  Created by Andy Kayley on 05/05/2022.
//

import Combine
import Foundation

class Expenses: ObservableObject {

    @Published var items: [ExpenseItem] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }

    init() {
        guard let savedItems = UserDefaults.standard.data(forKey: "items") else {
            items = []
            return
        }

        guard let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) else {
            items = []
            return
        }

        items = decodedItems
    }
}
