//
//  JsonFileCardRepository.swift
//  Flashzilla
//
//  Created by Andy Kayley on 28/09/2022.
//

import Foundation

class JsonFileCardRepository: CardRepository {

    private enum FileNames: String {
        case cards = "cards.json"
    }

    func loadCards() async throws -> [Card] {
        try FileManager.decode(FileNames.cards.rawValue)
    }

    func saveCards(_ cards: [Card]) async throws {
        try FileManager.encode(value: cards, to: FileNames.cards.rawValue)
    }
}
