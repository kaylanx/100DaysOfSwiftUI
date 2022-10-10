//
//  RollDiceView.swift
//  Dice
//
//  Created by Andy Kayley on 09/10/2022.
//

import SwiftUI

struct RollDiceView: View {
    
    @State private var dice: [DiceContainer] = [.init(dice: SixSidedDice.one)]
    @State private var previouslyRolled: [Int] = []
    @State private var isShowingSettings = false
    @State private var numberOfDice = 1
    @State private var diceType: DiceType = .sixSided

    private var columns: [GridItem] {
        Array(
            repeating: GridItem(.flexible(minimum: 30)),
            count: dice.count > 3 ? 2 : dice.count
        )
    }

    private var previouslyRolledDisplay: String {
        previouslyRolled.map {
            "\($0)"
        }.joined(separator: ", ")
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
                        previousRolls
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

    @ViewBuilder
    private var previousRolls: some View {
        if previouslyRolled.count > 0 {
            VStack {
                Text("Previously rolled:")
                    .font(.title)
                Text(previouslyRolledDisplay)
            }
            .padding(.top)
            .foregroundColor(.dicePrimary)
        }
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
            previouslyRolled.append(diceTotal)
            resetDice(numberOfDice: numberOfDice)
        }
        .padding()
        .background(Color.dicePrimary)
        .foregroundColor(.diceSecondary)
        .clipShape(Capsule())
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
}

struct RollDiceView_Previews: PreviewProvider {
    static var previews: some View {
        RollDiceView()
    }
}
