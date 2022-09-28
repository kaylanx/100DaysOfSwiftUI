//
//  CardViewModel.swift
//  Flashzilla
//
//  Created by Andy Kayley on 28/09/2022.
//

import Foundation

class CardViewModel: ObservableObject {

    @Published var cards = [Card]()

    @MainActor
    func addCard(card: Card) {
        Task {
            cards.insert(card, at: 0)
            saveData()
        }
    }

    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }

    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                DispatchQueue.main.async {
                    self.cards = decoded
                }
            }
        }
    }

    func saveData() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: "Cards")
        }
    }
}
