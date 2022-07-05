//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Andy Kayley on 03/07/2022.
//

import CoreData
import SwiftUI

struct FilteredList<Entity: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<Entity>
    @ViewBuilder var listItem: (Entity) -> Content

    init(
        filterKey: String,
        filterPredicate: String = "BEGINSWITH",
        filterValue: String,
        listItem: @escaping (Entity) -> Content
    ) {
        _fetchRequest = FetchRequest<Entity>(
            sortDescriptors: [],
            predicate: NSPredicate(format: "%K \(filterPredicate) %@", filterKey, filterValue)
        )
        self.listItem = listItem
    }

    var body: some View {
        List(fetchRequest, id: \.self) { entity in
            listItem(entity)
        }
    }
}
