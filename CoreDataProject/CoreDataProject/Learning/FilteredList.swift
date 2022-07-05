//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Andy Kayley on 03/07/2022.
//

import CoreData
import SwiftUI

enum FilteredListPredicate: String {
    case beginsWith = "BEGINSWITH"
    case beginsWithIgnoreCase = "BEGINSWITH[c]"
    case contains = "CONTAINS"
    case containsIgnoreCase = "CONTAINS[c]"
}

struct FilteredList<Entity: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<Entity>
    @ViewBuilder var listItem: (Entity) -> Content

    init(
        filterKey: String,
        filterPredicate: FilteredListPredicate = .beginsWith,
        filterValue: String,
        listItem: @escaping (Entity) -> Content
    ) {
        _fetchRequest = FetchRequest<Entity>(
            sortDescriptors: [],
            predicate: NSPredicate(format: "%K \(filterPredicate.rawValue) %@", filterKey, filterValue)
        )
        self.listItem = listItem
    }

    var body: some View {
        List(fetchRequest, id: \.self) { entity in
            listItem(entity)
        }
    }
}
