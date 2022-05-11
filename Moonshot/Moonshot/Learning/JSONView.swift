//
//  JSONView.swift
//  Moonshot
//
//  Created by Andy Kayley on 11/05/2022.
//

import SwiftUI

struct JSONView: View {
    var body: some View {
        Button("Decode JSON") {

            struct User: Codable {
                let name: String
                let address: Address
            }

            struct Address: Codable {
                let street: String
                let city: String
            }

            let input = """
            {
                "name": "Taylor Swift",
                "address": {
                    "street": "555, Taylor Swift Avenue",
                    "city": "Nashville"
                }
            }
            """

            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: data) {
                print(user.address.street)
            }
        }
    }
}

struct JSONView_Previews: PreviewProvider {
    static var previews: some View {
        JSONView()
    }
}
