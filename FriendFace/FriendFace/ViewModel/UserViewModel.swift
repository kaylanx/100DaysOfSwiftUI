//
//  UserViewModel.swift
//  FriendFace
//
//  Created by Andy Kayley on 06/07/2022.
//

import Foundation

@MainActor
final class UserViewModel: ObservableObject {
    @Published var users = [User]()

    var hasUsers: Bool {
        users.isEmpty == false
    }

    let userRepository: UserProviding

    init(userRepository: UserProviding = UserRepository()) {
        self.userRepository = userRepository
    }

    func getUsers() async {
        users = await userRepository.getUsers()
    }
}
