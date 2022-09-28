//
//  CardViewModel.swift
//  Flashzilla
//
//  Created by Andy Kayley on 28/09/2022.
//

import Foundation

class CardViewModel: ObservableObject {

    @Published var cards = [Card]()
    private var cardRepository: CardRepository

    init(
        cardRepository: CardRepository = UserDefaultsCardRepository()
    ) {
        self.cardRepository = cardRepository
    }

    @MainActor
    func addCard(card: Card) {
        Task {
            cards.insert(card, at: 0)
            saveCards()
        }
    }

    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveCards()
    }

    func loadData() {
        Task { @MainActor in
            do {
                self.cards = try await cardRepository.loadCards()
            } catch {
                // Error handling out of scope
                print(error)
            }
        }
    }

    func saveCards() {
        Task {
            do {
                try await cardRepository.saveCards(cards)
            } catch {
                // Error handling out of scope
                print(error)
            }
        }
    }
}
