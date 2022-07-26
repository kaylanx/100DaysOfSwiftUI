//
//  TouchFaceIdExampleView.swift
//  BucketList
//
//  Created by Andy Kayley on 26/07/2022.
//

import LocalAuthentication
import SwiftUI

struct TouchFaceIdExampleView: View {

    @State private var isUnlocked = false

    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let touchIdReason = "We want to unlock your data"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: touchIdReason) { success, authenticationError in
                if success {
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
}

struct TouchFaceIdExampleView_Previews: PreviewProvider {
    static var previews: some View {
        TouchFaceIdExampleView()
    }
}
