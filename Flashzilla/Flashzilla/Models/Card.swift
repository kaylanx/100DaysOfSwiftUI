//
//  Card.swift
//  Flashzilla
//
//  Created by Andy Kayley on 22/09/2022.
//

import Foundation

struct Card {
    let prompt: String
    let answer: String 
}

extension Card: Codable { }

extension Card: Hashable { }
