//
//  SettingsView.swift
//  Dice
//
//  Created by Andy Kayley on 09/10/2022.
//

import SwiftUI

struct SettingsView: View {

    @Binding var isPresented: Bool
    @Binding var numberOfDice: Int
    @Binding var diceType: DiceType

    var body: some View {
        SheetView(isPresented: $isPresented) {
            Form {
                Section("Settings") {
                    Picker(selection: $numberOfDice) {
                        ForEach(1..<5, id: \.self) {
                            Text("\($0)")
                        }
                    } label: {
                        Text("How many dice?")
                    }
                    .colorMultiply(.diceSecondary)
                    .listRowBackground(Color.dicePrimary)

                    Picker(selection: $diceType) {
                        ForEach(DiceType.allCases, id: \.self) {
                            Text("\($0.rawValue)")
                        }
                    } label: {
                        Text("Type of dice")
                    }
                    .colorMultiply(.diceSecondary)
                    .listRowBackground(Color.dicePrimary)
                }
                .foregroundColor(.dicePrimary)
            }
            .scrollContentBackground(.hidden)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(
            isPresented: .constant(true),
            numberOfDice: .constant(4),
            diceType: .constant(.sixSided)
        )
        .preferredColorScheme(.light)
        .previewDisplayName("Light")

        SettingsView(
            isPresented: .constant(true),
            numberOfDice: .constant(4),
            diceType: .constant(.sixSided)
        )
        .preferredColorScheme(.dark)
        .previewDisplayName("Dark")
    }
}
