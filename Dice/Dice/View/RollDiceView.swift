//
//  RollDiceView.swift
//  Dice
//
//  Created by Andy Kayley on 09/10/2022.
//

import SwiftUI

struct RollDiceView: View {


    @Environment(\.managedObjectContext) private var managedObjectContext

    @State private var dice: [DiceContainer] = [.init(dice: SixSidedDice.one)]
    @State private var isShowingSettings = false
    @State private var isShowingPreviousRolls = false
    @State private var numberOfDice = 1
    @State private var diceType: DiceType = .sixSided

    private var columns: [GridItem] {
        Array(
            repeating: GridItem(.flexible(minimum: 30)),
            count: dice.count > 3 ? 2 : dice.count
        )
    }

    private var diceTotal: Int {
        let totalRolled = dice.reduce(into: Int()) { partialResult, die in
            partialResult += die.dice.rawValue
        }
        return totalRolled
    }

    var body: some View {
        NavigationView {
            ZStack {
                background
                VStack {
                    header
                    Spacer()
                    LazyVGrid(
                        columns: columns,
                        spacing: 20
                    ) {
                        ForEach(dice) { die in
                            DiceView(dice: die.dice)
                        }
                    }
                    rollTotal
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    VStack {
                        previousRollsButton
                        rollDiceButton
                    }
                }
                .padding()
            }
            .navigationBarItems(trailing: settingsButton)
            .sheet(isPresented: $isShowingSettings) {
                SettingsView(
                    isPresented: $isShowingSettings,
                    numberOfDice: $numberOfDice,
                    diceType: $diceType
                )
            }
            .sheet(isPresented: $isShowingPreviousRolls){
                PreviousRollsView(isPresented: $isShowingPreviousRolls)
            }
            .onChange(of: numberOfDice, perform: resetDice(numberOfDice:))
            .onChange(of: diceType) { _ in resetDice(numberOfDice:numberOfDice) }
        }
        .tint(.diceSecondary)
    }

    private var header: some View {
        LogoView()
    }

    private var background: some View {
        RadialGradient(
            stops: [
                .init(color: .diceSecondary, location: 0.1),
                .init(color: .dicePrimary, location: 0.1)
            ],
            center: .top,
            startRadius: 700,
            endRadius: 200
        )
        .ignoresSafeArea()
    }

    private var rollTotal: some View {
        Text("\(diceTotal)")
            .font(.title)
            .foregroundColor(.diceSecondary)
    }

    private var settingsButton: some View {
        Button {
            isShowingSettings.toggle()
        } label: {
            Image(systemName: "gearshape")
        }
    }

    private var rollDiceButton: some View {
        Button("Roll dice") {
            saveRoll()
            resetDice(numberOfDice: numberOfDice)
        }
        .padding()
        .background(Color.dicePrimary)
        .foregroundColor(.diceSecondary)
        .clipShape(Capsule())
    }

    private var previousRollsButton: some View {
        Button("See previous rolls") {
            isShowingPreviousRolls.toggle()
        }
        .padding()
        .foregroundColor(.dicePrimary)
    }

    private func resetDice(numberOfDice: Int) {
        dice = []
        for _ in 0..<numberOfDice {
            dice.append(.init(dice: randomDiceRoll()))
        }
    }

    private func randomDiceRoll() -> any Dice {
        diceType.roll()
    }

    private func saveRoll() {
        let diceRoll = DiceRoll(context: managedObjectContext)
        diceRoll.id = UUID()
        diceRoll.numberOfDice = Int16(numberOfDice)
        diceRoll.numberOfSides = Int16(diceType.numberOfSides)
        diceRoll.totalRolled = Int16(diceTotal)
        diceRoll.dateOfRoll = Date()

        try? managedObjectContext.save()
    }
}

struct RollDiceView_Previews: PreviewProvider {
    static var previews: some View {
        RollDiceView()
    }
}
