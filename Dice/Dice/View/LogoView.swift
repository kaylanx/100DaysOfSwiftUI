//
//  LogoView.swift
//  Dice
//
//  Created by Andy Kayley on 09/10/2022.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "dice")
                .imageScale(.large)
            Text("Dice!")
        }
        .foregroundColor(.diceSecondary)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
