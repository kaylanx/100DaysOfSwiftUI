//
//  HidingAndGroupingView.swift
//  AccessibilityExampleApp
//
//  Created by Andy Kayley on 02/08/2022.
//

import SwiftUI

struct HidingAndGroupingView: View {
    var body: some View {
        ZStack {
            Image(decorative: "matteo-vella-eaGdR5Wxp1U-unsplash")
                .resizable()
                .scaledToFit()
                .accessibility(hidden: true)
            VStack {
                VStack {
                    Text("Your score is")
                    Text("1000")
                        .font(.title)
                }
                .accessibilityElement(children: .combine)
                VStack {
                    Text("Your score is")
                    Text("1000")
                        .font(.title)
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Your score is 1000")
            }
        }
    }
}

struct HidingAndGroupingView_Previews: PreviewProvider {
    static var previews: some View {
        HidingAndGroupingView()
    }
}
