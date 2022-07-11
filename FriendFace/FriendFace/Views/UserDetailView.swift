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
        List {
            Section(header: VStack(alignment: .center) {
                Text(user.name)
                    .font(.largeTitle)
                Text(user.company)
                    .font(.body)
                    .foregroundColor(.gray)
            }
            ) {
                EmptyView()
            }
            .headerProminence(.increased)


            Section(header: Text("General Info")) {
                cell(with: "Member since", for: "\(user.formattedRegistered)")
            }
            Section {
                cell(with: "Age", for: "\(user.age)")
            }
            Section {
                cell(with: "Email", for: user.email)
                cell(with: "Address", for: user.address)
            }
            Section {
                cell(with: "About", for: user.about)
            }
            Section(header: Text("Tags")) {
                ForEach(user.tags, id: \.self) { tag in
                    Text(tag)
                }
            }
            Section(header: Text("Friends")) {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            }
        }
        .listStyle(.grouped)
        .navigationBarTitleDisplayMode(.inline)

    }

    func cell(with title: String, for content: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption2)
            Text(content)
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
