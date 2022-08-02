//
//  AccessibilityLabelsAndTraits.swift
//  AccessibilityExampleApp
//
//  Created by Andy Kayley on 02/08/2022.
//

import SwiftUI

struct AccessibilityLabelsAndTraits: View {
    private let pictures = [
        "alp-duran-0FBPTRQmYu4-unsplash",
        "anshu-a-B5yD1S6uhmQ-unsplash",
        "jeremy-hynes-YuAFaICWrKA-unsplash",
        "matteo-vella-eaGdR5Wxp1U-unsplash"
    ]

    private let labels = [
        "Arch",
        "Fruit, veg and shopping bag",
        "Deer",
        "Clownfish",
    ]

    @State private var selectedPicture = Int.random(in: 0...3)

    var body: some View {
        Image(pictures[selectedPicture])
            .resizable()
            .scaledToFit()
            .onTapGesture {
                selectedPicture = Int.random(in: 0...3)
            }
            .accessibilityLabel(labels[selectedPicture])
            .accessibilityAddTraits(.isButton)
            .accessibilityRemoveTraits(.isImage)
    }
}

struct AccessibilityLabelsAndTraits_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityLabelsAndTraits()
    }
}
