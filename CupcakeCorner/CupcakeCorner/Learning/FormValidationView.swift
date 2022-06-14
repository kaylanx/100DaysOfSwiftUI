//
//  FormValidationView.swift
//  CupcakeCorner
//
//  Created by Andy Kayley on 14/06/2022.
//

import SwiftUI

struct FormValidationView: View {
    @State private var username = ""
    @State private var email = ""

    var disabledForm: Bool {
        username.count < 5 || email.count < 5
    }

    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account")
                }
            }
            .disabled(disabledForm)
        }
    }
}

struct FormValidationView_Previews: PreviewProvider {
    static var previews: some View {
        FormValidationView()
    }
}
