//
//  CodableExampleView.swift
//  iExpense
//
//  Created by Andy Kayley on 04/05/2022.
//

import SwiftUI

struct User: Codable {
    let firstName: String
    let lastName: String
}


struct CodableExampleView: View {

    @State private var user = User(firstName: "Taylor", lastName: "Swift")

    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
}

struct CodableExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CodableExampleView()
    }
}
