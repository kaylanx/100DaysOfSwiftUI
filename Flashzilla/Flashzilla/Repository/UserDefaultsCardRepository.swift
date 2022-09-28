//
//  UserDefaultsCardRepository.swift
//  Flashzilla
//
//  Created by Andy Kayley on 28/09/2022.
//

import Foundation

class UserDefaultsCardRepository: CardRepository {

    private enum UserDefaultKeys: String {
        case cards = "Cards"
    }

    func loadCards() async throws -> [Card] {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultKeys.cards.rawValue) else { return [Card]() }
        guard let decoded = try? JSONDecoder().decode([Card].self, from: data) else { return [Card]() }
        return decoded
    }

    func saveCards(_ cards: [Card]) async throws {
        guard let data = try? JSONEncoder().encode(cards) else { return }
        UserDefaults.standard.set(data, forKey: UserDefaultKeys.cards.rawValue)
    }
}
