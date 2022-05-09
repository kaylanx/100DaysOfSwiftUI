//
//  Expenses.swift
//  iExpense
//
//  Created by Andy Kayley on 05/05/2022.
//

import Combine
import Foundation

class Expenses: ObservableObject {
    @Published var personalItems = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(personalItems) {
                UserDefaults.standard.set(encoded, forKey: "personalItems")
            }
        }
    }

    @Published var businessItems = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(businessItems) {
                UserDefaults.standard.set(encoded, forKey: "businessItems")
            }
        }
    }

    init() {
        personalItems = []
        businessItems = []
        if let savedBusinessItems = UserDefaults.standard.data(forKey: "businessItems") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedBusinessItems) {
                businessItems = decodedItems

                if let savedPersonalItems = UserDefaults.standard.data(forKey: "personalItems") {
                    if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedPersonalItems) {
                        personalItems = decodedItems
                        return
                    }
                }
            }
        }
    }
}
