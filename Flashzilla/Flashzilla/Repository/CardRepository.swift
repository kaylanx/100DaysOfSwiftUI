//
//  CardRepository.swift
//  Flashzilla
//
//  Created by Andy Kayley on 28/09/2022.
//

import Foundation

protocol CardRepository {
    func loadCards() async throws -> [Card]
    func saveCards(_ cards: [Card]) async throws
}
