//
//  Prospect.swift
//  Hot Prospects
//
//  Created by Andy Kayley on 14/09/2022.
//

import Foundation

final class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

@MainActor final class Prospects: ObservableObject {
    @Published var people: [Prospect]

    init() {
        self.people = []
    }

    func toggleContacted(for prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
    }
}
