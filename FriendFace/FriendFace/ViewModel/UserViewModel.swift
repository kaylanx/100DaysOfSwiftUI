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

    let remoteUserRepository: UserRepository
    let localUserRepository: UserRepositoryStore

    init(
        remoteUserRepository: UserRepository = RemoteUserRepository(),
        localUserRepository: UserRepositoryStore = CoreDataUserRepository()
    ) {
        self.remoteUserRepository = remoteUserRepository
        self.localUserRepository = localUserRepository
    }

    func getUsers() async {
        do {
            users = try await remoteUserRepository.getUsers()
            localUserRepository.save(users: users)
        } catch {
            // Error handling is out of scope for this project
            print("Error \(error)")

            // 1. Check for internet connection failed error
            // 2. if internet connection failed read data from core data
            do {
                users = try await localUserRepository.getUsers()
            } catch {
                // Error handling is out of scope for this project
                print("Error \(error)")
                users = [ User(id: "", isActive: false, name: "Error occurred - Reload App", age: 0, company: "", email: "", address: "", about: "", registered: Date(), tags: [], friends: [])]
            }
        }
    }
}
