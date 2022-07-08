//
//  ContentView.swift
//  FriendFace
//
//  Created by Andy Kayley on 06/07/2022.
//

import SwiftUI

struct ContentView: View {

    @StateObject var viewModel: UserViewModel

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
                        Circle()
                            .strokeBorder(
                                user.isActive ? .green : .gray,
                                lineWidth: 1.5
                            )
                            .background(
                                Circle()
                                    .fill(
                                        user.isActive ? Color.green : Color.white
                                    )
                            )
                            .frame(width: 15)
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

    private static var viewModel = UserViewModel(userRepository: PreviewUserRepository())

    static var previews: some View {
        ContentView(viewModel: viewModel)
    }
}
