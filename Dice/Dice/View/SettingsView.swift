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

    var body: some View {
        NavigationView {
            ZStack {
                Color.dicePrimary
                    .ignoresSafeArea()

                Form {
                    Section("Settings") {
                        Picker("How many dice?", selection: $numberOfDice) {
                            ForEach(1..<5, id: \.self) {
                                Text("\($0)")
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        LogoView()
                    }
                    .padding()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    VStack {
                        Button {
                            isPresented.toggle()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.diceSecondary)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .tint(.dicePrimary)
        }
        .foregroundColor(.diceSecondary)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(
            isPresented: .constant(true),
            numberOfDice: .constant(4)
        )
    }
}
