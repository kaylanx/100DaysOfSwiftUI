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

    @FetchRequest(sortDescriptors: [SortDescriptor(\.dateOfRoll, order: .reverse)])
    var diceRolls: FetchedResults<DiceRoll>

    private let titleFont = Font.headline

    var body: some View {
        SheetView(isPresented: $isPresented) {
            List {
                ForEach(diceRolls) { diceRoll in
                    VStack(alignment: .leading) {
                        textFor(title: "Number of dice: ", contents: "\(diceRoll.numberOfDice)")
                        textFor(title: "Sides on die: ", contents: "\(diceRoll.numberOfSides)")
                        textFor(title: "Total rolled: ", contents: "\(diceRoll.totalRolled)")
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
    }

    private func textFor(title: String, contents: String) -> some View {
        HStack {
            Text(title)
                .font(titleFont)
            +
            Text(contents)
        }
    }
}

struct PreviousRollsView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousRollsView(isPresented: .constant(true))
    }
}
