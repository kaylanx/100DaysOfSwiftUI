//
//  MasterDetail.swift
//  SnowSeeker
//
//  Created by Andy Kayley on 27/10/2022.
//

import SwiftUI

enum MasterDetail {
    struct User: Identifiable {
        var id = "Taylor Swift"
    }

    struct ContentView: View {

        @State private var isShowingUser = false
        @State private var selectedUser: User? = nil

        var body: some View {
            NavigationView {
                NavigationLink {
                    Text("New secondary")
                        .onTapGesture {
                            selectedUser = User()
                        }

                } label: {
                    Text("Hello, World!")

                }
                .navigationTitle("Primary")

                Text("Secondary")
                    .onTapGesture {
                        selectedUser = User()
                        isShowingUser = true
                    }

            }
            .sheet(item: $selectedUser) { user in
                Text(user.id)
            }
            .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
                Button(user.id) { }
            }
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
