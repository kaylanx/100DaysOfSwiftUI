//
//  ConfirmationDialogView.swift
//  Instafilter
//
//  Created by Andy Kayley on 17/07/2022.
//

import SwiftUI

struct ConfirmationDialogView: View {

    @State private var isShowingConfirmation = false
    @State private var backgroundColor = Color.white

    var body: some View {
        Text("Hello, World!")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                isShowingConfirmation = true
            }
            .confirmationDialog("ChangeBackground", isPresented: $isShowingConfirmation) {
                Button("Red") { backgroundColor = .red }
                Button("Green") { backgroundColor = .green }
                Button("Blue") { backgroundColor = .blue }
                Button("White") { backgroundColor = .white }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Select a new colour")
            }
    }
}

struct ConfirmationDialogView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationDialogView()
    }
}
