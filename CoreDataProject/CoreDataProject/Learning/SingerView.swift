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
    @State private var predicate: String = "BEGINSWITH"

    var body: some View {
        VStack {
            FilteredList(filterKey: "lastName", filterPredicate: predicate, filterValue: lastNameFilter) { (singer: Singer) in
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
                predicate = "BEGINSWITH"
            }

            Button("Show BEGINSWITH S") {
                lastNameFilter = "S"
                predicate = "BEGINSWITH"
            }

            Button("Show CONTAINS A") {
                lastNameFilter = "A"
                predicate = "CONTAINS[c]"
            }

            Button("Show CONTAINS S") {
                lastNameFilter = "S"
                predicate = "CONTAINS[c]"
            }
        }
    }
}

struct SingerView_Previews: PreviewProvider {
    static var previews: some View {
        SingerView()
    }
}
