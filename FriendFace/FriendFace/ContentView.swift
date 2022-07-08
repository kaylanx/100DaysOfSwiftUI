//
//  ContentView.swift
//  FriendFace
//
//  Created by Andy Kayley on 06/07/2022.
//

import SwiftUI

struct ContentView: View {

    var viewModel: UserViewModel

    var body: some View {
        NavigationView {
            UserListView(viewModel: viewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {

    private static var viewModel = UserViewModel(userRepository: PreviewUserRepository())

    static var previews: some View {
        ContentView(viewModel: viewModel)
    }
}
