//
//  PreviousRollsView.swift
//  Dice
//
//  Created by Andy Kayley on 10/10/2022.
//

import CoreData
import SwiftUI

struct PreviousRollsView: View {

    @Binding var isPresented: Bool

    @Environment(\.managedObjectContext) private var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.dateOfRoll, order: .reverse)])
    var diceRolls: FetchedResults<DiceRoll>

    private let titleFont = Font.headline

    var body: some View {
        SheetView(isPresented: $isPresented) {
            if diceRolls.count == 0 {
                Text("No dice rolls yet, please roll the dice!")
            } else {
                List {
                    ForEach(diceRolls) { diceRoll in
                        VStack(alignment: .leading) {
                            textFor(title: "Number of dice: ", contents: "\(diceRoll.numberOfDice)")
                            textFor(title: "Sides on die: ", contents: "\(diceRoll.numberOfSides)")
                            textFor(title: "Total rolled: ", contents: "\(diceRoll.totalRolled)")
                        }
                        .listRowBackground(Color.dicePrimary)
                    }
                    .onDelete(perform: deleteRolls)
                }
                .scrollContentBackground(.hidden)

            }
        }
    }

    private func textFor(title: String, contents: String) -> some View {
        HStack {
            Text(title)
                .font(titleFont)
            +
            Text(contents)
        }
        .foregroundColor(.diceSecondary)
    }

    func deleteRolls(at offsets: IndexSet) {
        for index in offsets {
            let language = diceRolls[index]
            managedObjectContext.delete(language)
        }
        try? managedObjectContext.save()
    }
}

struct PreviousRollsView_Previews: PreviewProvider {

    private static let diceRolls = [
        [
            "totalRolled": Int16(4),
            "numberOfSides": Int16(6),
            "numberOfDice": Int16(1),
            "dateOfRoll": Date()
        ],
        [
            "totalRolled": Int16(12),
            "numberOfSides": Int16(6),
            "numberOfDice": Int16(2),
            "dateOfRoll": Date()
        ],
        [
            "totalRolled": Int16(14),
            "numberOfSides": Int16(4),
            "numberOfDice": Int16(4),
            "dateOfRoll": Date()
        ],
    ]

    static var previews: some View {
        let previewDataController = PreviewDataController()

        previewDataController.savePreviewData(diceRolls: diceRolls)

        return PreviousRollsView(isPresented: .constant(true))
            .environment(
                \.managedObjectContext,
                 previewDataController.viewContext
            )
    }
}
