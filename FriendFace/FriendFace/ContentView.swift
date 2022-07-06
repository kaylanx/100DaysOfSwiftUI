//
//  ContentView.swift
//  FriendFace
//
//  Created by Andy Kayley on 06/07/2022.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        VStack {
            if viewModel.hasUsers == false {
                ProgressView()
            }
            else {
                List(viewModel.users) { user in
                    HStack {
                        Text(user.name)
                        Spacer()
                        Text(user.isActive ? "Active" : "Inactive")
                    }
                }
            }
        }
        .task {
            await viewModel.getUsers()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
