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
                Color.dicePrimary
                    .ignoresSafeArea()
                content
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        LogoView()
                    }
                    .padding()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    VStack {
                        Button {
                            isPresented.toggle()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.diceSecondary)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .tint(.dicePrimary)
        }
        .foregroundColor(.diceSecondary)
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(isPresented: .constant(true)) {
            Text("Content")
        }
    }
}
