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

enum SortOptions {
    case name, dateAdded
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

    func all(sortedBy: SortOptions = .name) -> [Prospect] {
        sort(prospects: people, by: sortedBy)
    }

    private func sort(prospects: [Prospect], by sortedBy: SortOptions = .name) -> [Prospect] {
        switch sortedBy {
            case .name:
                return sortByName(prospects: prospects)
            case .dateAdded:
                return sortByMostRecent(prospects: prospects)
        }
    }

    private func sortByName(prospects: [Prospect]) -> [Prospect] {
        prospects.sorted {
            $0.name < $1.name
        }
    }

    private func sortByMostRecent(prospects: [Prospect]) -> [Prospect] {
        prospects.sorted {
            $0.dateAdded > $1.dateAdded
        }
    }

    func contacted(sortedBy: SortOptions = .name) -> [Prospect] {
        sort(prospects: people.filter { $0.isContacted }, by: sortedBy)
    }

    func uncontacted(sortedBy: SortOptions = .name) -> [Prospect] {
        sort(prospects: people.filter { !$0.isContacted }, by: sortedBy)
    }

    private func save() {
        do {
            try FileManager.encode(value: people, to: Prospects.savedDataKey)
        } catch {
            print(error)
        }
    }
}
