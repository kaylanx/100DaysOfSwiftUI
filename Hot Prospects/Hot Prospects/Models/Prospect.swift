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
    var dateAdded = Date()
    fileprivate(set) var isContacted = false
}

@MainActor final class Prospects: ObservableObject {

    private static let savedDataKey = "SavedData.json"

    @Published private(set) var people: [Prospect]

    init() {
        do {
            people = try FileManager.decode(Prospects.savedDataKey)
        } catch {
            print(error)
            people = []
        }
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
        do {
            try FileManager.encode(value: people, to: Prospects.savedDataKey)
        } catch {
            print(error)
        }
    }
}
