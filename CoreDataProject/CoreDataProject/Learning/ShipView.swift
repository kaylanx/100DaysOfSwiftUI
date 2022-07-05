//
//  ShipView.swift
//  CoreDataProject
//
//  Created by Andy Kayley on 03/07/2022.
//

import CoreData
import SwiftUI

struct ShipView: View {

    @Environment(\.managedObjectContext) var context
//    static let predicate = NSPredicate(format: "universe == %@", "Star Wars")
//    static let predicate = NSPredicate(format: "name < %@", "F")
//    static let predicate = NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
//    static let predicate = NSPredicate(format: "name BEGINSWITH %@", "E") // Case sensitive
//    static let predicate = NSPredicate(format: "name BEGINSWITH[c] %@", "e") // Case insensitive
    static let predicate = NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e") // NEGATIVE


    @FetchRequest(sortDescriptors: [], predicate: predicate) var ships: FetchedResults<Ship>

    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }
        }

        Button("Add Examples") {
            let ship1 = Ship(context: context)
            ship1.name = "Enterprise"
            ship1.universe = "Star Trek"

            let ship2 = Ship(context: context)
            ship2.name = "Defiant"
            ship2.universe = "Star Trek"

            let ship3 = Ship(context: context)
            ship3.name = "Millennium Falcon"
            ship3.universe = "Star Wars"

            let ship4 = Ship(context: context)
            ship4.name = "Executor"
            ship4.universe = "Star Wars"

            try? context.save()
        }
    }
}

struct ShipView_Previews: PreviewProvider {
    static var previews: some View {
        ShipView()
    }
}
