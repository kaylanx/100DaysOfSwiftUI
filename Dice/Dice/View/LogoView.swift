//
//  LogoView.swift
//  Dice
//
//  Created by Andy Kayley on 09/10/2022.
//

import SwiftUI

struct LogoView: View {

    enum LogoAlignment {
        case horizontal
        case vertical
    }

    var alignment: LogoAlignment = .vertical

    var body: some View {
        switch alignment {
            case .horizontal:
                HStack(spacing: 0, content: { logo })
            case .vertical:
                VStack(spacing: 0, content: { logo })
        }
    }

    private var logo: some View {
        Group {
            Image(systemName: "dice")
                .imageScale(.large)
            Text("Dice!")
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView(alignment: .vertical)
            .previewLayout(.fixed(width: 100, height: 100))
            .previewDisplayName("Vertical Logo")

        LogoView(alignment: .horizontal)
            .previewLayout(.fixed(width: 100, height: 100))
            .previewDisplayName("Horizontal Logo")
    }
}
