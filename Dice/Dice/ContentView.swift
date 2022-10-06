//
//  ContentView.swift
//  Dice
//
//  Created by Andy Kayley on 06/10/2022.
//

import SwiftUI

struct ContentView: View {

    @State private var dice: Dice = SixSidedDice.allCases.randomElement()!
    @State private var previouslyRolled: [Int] = []

    private var previouslyRolledDisplay: String {
        previouslyRolled.map {
            "\($0)"
        }.joined(separator: ", ")
    }

    var body: some View {
        ZStack {
            background
            VStack {
                header
                Spacer()
                DiceView(dice: dice)
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                previousRolls
                rollDiceButton
            }
            .padding()
        }
    }

    private var header: some View {
        Group {
            Image(systemName: "dice")
                .imageScale(.large)
                .foregroundColor(.diceSecondary)
            Text("Dice!")
                .foregroundColor(.diceSecondary)
        }
    }

    private var background: some View {
        RadialGradient(
            stops: [
                .init(color: .diceSecondary, location: 0.6),
                .init(color: .dicePrimary, location: 0.6)
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

    private var rollDiceButton: some View {
        Button("Roll dice") {
            withAnimation {
                previouslyRolled.append(dice.rawValue)
                dice = SixSidedDice.allCases.randomElement()!
            }
        }
        .padding()
        .background(Color.dicePrimary)
        .foregroundColor(.diceSecondary)
        .clipShape(Capsule())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
