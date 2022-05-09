//
//  ObservedObjectExampleView.swift
//  iExpense
//
//  Created by Andy Kayley on 04/05/2022.
//

import SwiftUI

class ObservedExampleUser: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct ObservedObjectExampleView: View {
    @StateObject var user = ObservedExampleUser()

    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
    }
}

struct ObservedObjectExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ObservedObjectExampleView()
    }
}
