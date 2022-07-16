//
//  UserListView.swift
//  FriendFace
//
//  Created by Andy Kayley on 08/07/2022.
//

import SwiftUI

struct UserListView: View {
    @StateObject var viewModel: UserViewModel

    var body: some View {
        VStack {
            if viewModel.hasUsers == false {
                ProgressView()
            }
            else {
                List(viewModel.users) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        cell(for: user)
                    }
                }
            }
        }
        .navigationTitle("Users")
        .task {
            if viewModel.hasUsers == false {
                await viewModel.getUsers()
            }
        }
    }

    private func cell(for user: User) -> some View {
        HStack {
            Text(user.name)
            Spacer()
            Circle()
                .strokeBorder(
                    user.isActive ? .green : .secondaryLabel,
                    lineWidth: 1.5
                )
                .background(
                    Circle()
                        .fill(
                            user.isActive ? Color.green : Color.secondarySystemGroupedBackground
                        )
                )
                .frame(width: 15)
        }
    }
}

struct UserListView_Previews: PreviewProvider {

    private static var viewModel = UserViewModel(
        remoteUserRepository: PreviewUserRepository(),
        localUserRepository: PreviewUserRepository()
    )

    static var previews: some View {
        UserListView(viewModel: viewModel)

        UserListView(viewModel: viewModel)
            .preferredColorScheme(.dark)

    }
}
