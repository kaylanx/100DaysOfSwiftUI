//
//  CoreDataUserRepository.swift
//  FriendFace
//
//  Created by Andy Kayley on 15/07/2022.
//

import Foundation
import CoreData

protocol UserRepositoryStore: UserRepository {
    func save(users: [User])
}

final class CoreDataUserRepository: UserRepositoryStore {

    private let container = NSPersistentContainer(name: "FriendFace")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData failed to load \(error.localizedDescription)")
                return
            }

            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }

    func getUsers() async throws -> [User] {
        do {
            let cachedUsers = try self.container.viewContext.fetch(CachedUser.fetchRequest())
            return cachedUsers.map { cachedUser in
                cachedUser.toUser()
            }
        } catch {
            print(error)
            return []
        }
    }

    func save(users: [User]) {
        users.forEach { user in
            CachedUser(context: container.viewContext)
                .set(user: user)
        }

        try? container.viewContext.save()
    }
}
