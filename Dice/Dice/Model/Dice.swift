//
//  Dice.swift
//  Dice
//
//  Created by Andy Kayley on 06/10/2022.
//

import Foundation

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
