//
//  DiceView.swift
//  Dice
//
//  Created by Andy Kayley on 06/10/2022.
//

import SwiftUI

struct DiceView: View {

    let dice: Dice

    var body: some View {
        Image(dice.imageName)
            .resizable()
            .frame(width: 100, height: 100)
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(SixSidedDice.allCases, id: \.self) { dice in
                DiceView(dice: dice)
                    .previewLayout(PreviewLayout.fixed(width: 100, height: 100))
                    .previewDisplayName("\(dice)")
            }
        }
    }
}
