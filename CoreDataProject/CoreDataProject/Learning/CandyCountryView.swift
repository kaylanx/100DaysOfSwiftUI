//
//  CandyCountryView.swift
//  CoreDataProject
//
//  Created by Andy Kayley on 04/07/2022.
//

import SwiftUI

struct CandyCountryView: View {

    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>

    var body: some View {
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(country.unwrappedFullName) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.unwrappedName)
                        }
                    }
                }
            }

            Button("Add examples") {
                let candy1 = Candy(context: context)
                candy1.name = "Mars"
                candy1.origin = Country(context: context)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"

                let candy2 = Candy(context: context)
                candy2.name = "KitKat"
                candy2.origin = Country(context: context)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"

                let candy3 = Candy(context: context)
                candy3.name = "Twix"
                candy3.origin = Country(context: context)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"

                let candy4 = Candy(context: context)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: context)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"

                try? context.save()
            }
        }
    }
}

struct CandyCountryView_Previews: PreviewProvider {
    static var previews: some View {
        CandyCountryView()
    }
}
