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

    private static let savedDataKey = "SavedData"

    @Published private(set) var people: [Prospect]

    init() {
        if let data = UserDefaults.standard.data(forKey: Prospects.savedDataKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                return
            }
        }
        people = []
    }

    func toggleContacted(for prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }

    func add(prospect: Prospect) {
        people.append(prospect)
        save()
    }

    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded, forKey: Prospects.savedDataKey)
        }
    }
}
