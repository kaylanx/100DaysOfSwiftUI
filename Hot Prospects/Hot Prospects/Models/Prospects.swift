//
//  Prospects.swift
//  Hot Prospects
//
//  Created by Andy Kayley on 14/09/2022.
//

import Foundation

@MainActor final class Prospects: ObservableObject {
    @Published var people: [Prospect]

    init() {
        self.people = []
    }
}
