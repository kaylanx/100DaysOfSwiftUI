//
//  SheetView.swift
//  Dice
//
//  Created by Andy Kayley on 11/10/2022.
//

import SwiftUI

struct SheetView<Content: View>: View {

    @Binding var isPresented: Bool

    @ViewBuilder
    var content: Content

    var body: some View {
        NavigationView {
            ZStack {
                Color.diceSecondary
                    .ignoresSafeArea()
                content
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        LogoView(alignment: .horizontal)
                            .foregroundColor(.dicePrimary)
                    }
                    .padding()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    VStack {
                        Button {
                            isPresented.toggle()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.dicePrimary)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .tint(.diceSecondary)
        }
        .foregroundColor(.dicePrimary)
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(isPresented: .constant(true)) {
            Text("Content")
        }
    }
}
