//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Andy Kayley on 08/07/2022.
//

import SwiftUI

struct UserDetailView: View {

    var user: User
    /*
     let name: String
     let age: Int
     let company: String
     let email: String
     let address: String
     let about: String
     let registered: Date
     let tags: [String]
     let friends: [Friend]
     */
    var body: some View {
        ScrollView {
            VStack {
                Text("Age: \(user.age)")
                Text(user.company)
                Text(user.email)
                Text(user.address)
                Text("About")
                Text(user.about)
            }
            .navigationTitle(user.name)
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserDetailView(user: PreviewUserRepository.users.first!)
        }
    }
}
