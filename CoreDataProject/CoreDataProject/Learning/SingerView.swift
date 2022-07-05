//
//  SingerView.swift
//  CoreDataProject
//
//  Created by Andy Kayley on 03/07/2022.
//

import SwiftUI

struct SingerView: View {

    @Environment(\.managedObjectContext) var context
    @State private var lastNameFilter = "A"
    @State private var predicate = FilteredListPredicate.beginsWith

    var body: some View {
        VStack {
            FilteredList(
                filterKey: "lastName",
                filterPredicate: predicate,
                filterValue: lastNameFilter,
                sortDescriptors: [
                    SortDescriptor(\Singer.lastName),
                    SortDescriptor(\Singer.firstName)
                ]
            ) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }

            Button("Add Examples") {
                let taylor = Singer(context: context)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: context)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: context)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? context.save()
            }

            Button("Show BEGINSWITH A") {
                lastNameFilter = "A"
                predicate = .beginsWith
            }

            Button("Show BEGINSWITH S") {
                lastNameFilter = "S"
                predicate = .beginsWith
            }

            Button("Show CONTAINS A") {
                lastNameFilter = "A"
                predicate = .containsIgnoreCase
            }

            Button("Show CONTAINS S") {
                lastNameFilter = "S"
                predicate = .containsIgnoreCase
            }
        }
    }
}

struct SingerView_Previews: PreviewProvider {
    static var previews: some View {
        SingerView()
    }
}
