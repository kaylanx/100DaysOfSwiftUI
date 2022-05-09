//
//  UserDefaultsExampleView.swift
//  iExpense
//
//  Created by Andy Kayley on 04/05/2022.
//

import SwiftUI

struct UserDefaultsExampleView: View {

    @AppStorage("tapCount") private var tapCount = 0

    var body: some View {
        VStack {
            Text("Poop")
            Button("Tap count: \(tapCount)") {
                tapCount += 1
            }
        }
    }
}

struct UserDefaultsExampleView_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultsExampleView()
    }
}
