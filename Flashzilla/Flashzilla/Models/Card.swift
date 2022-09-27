//
//  Card.swift
//  Flashzilla
//
//  Created by Andy Kayley on 22/09/2022.
//

import Foundation

struct Card: Identifiable {
    var id: String {
        prompt + answer
    }
    let prompt: String
    let answer: String 
}

extension Card: Codable { }

extension Card: Hashable { }
