//
//  Dice.swift
//  Dice
//
//  Created by Andy Kayley on 06/10/2022.
//

import Foundation

struct DiceContainer: Identifiable, Hashable {
    let dice: any Dice
    let id = UUID()

    static func == (lhs: DiceContainer, rhs: DiceContainer) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }
}

enum DiceType: String, CaseIterable, Equatable {
    case sixSided = "Six Sided"
    case fourSided = "Four Sided"

    func roll() -> Dice {
        switch self {
            case .sixSided:
                return SixSidedDice.allCases.randomElement()!
            case .fourSided:
                return FourSidedDice.allCases.randomElement()!
        }
    }

    var numberOfSides: Int {
        switch self {
            case .sixSided: return 6
            case .fourSided: return 4
        }
    }
}

protocol Dice {
    var imageName: String { get }
    var rawValue: Int { get }
}

enum SixSidedDice: Int, Dice, CaseIterable {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6

    var imageName: String {
        "SixSidedDice\(self.rawValue)"
    }
}

enum FourSidedDice: Int, Dice, CaseIterable {
    case one = 1
    case two = 2
    case three = 3
    case four = 4

    var imageName: String {
        "FourSidedDice\(self.rawValue)"
    }
}
