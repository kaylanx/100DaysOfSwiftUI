//
//  CachedUser+ModelMapping.swift
//  FriendFace
//
//  Created by Andy Kayley on 16/07/2022.
//

import Foundation

extension CachedUser {

    func toUser() -> User {

        let cachedFriendSet = friends as? Set<CachedFriend> ?? []
        let friends = cachedFriendSet.map { cachedFriend in
            cachedFriend.toFriend()
        }

        let user = User(
            id: id ?? "Unknown User Id",
            isActive: isActive,
            name: name ?? "Unknown User Name",
            age: Int(age),
            company: company ?? "Unknown User Company",
            email: email ?? "Unknown User Email",
            address: address ?? "Unknown User Address",
            about: about ?? "Unknown User About",
            registered: registered ?? Date(),
            tags: tags?.components(separatedBy: ",") ?? [],
            friends: friends
        )
        return user
    }

    func set(user: User) {
        self.id = user.id
        self.isActive = user.isActive
        self.name = user.name
        self.age = Int16(user.age)
        self.company = user.company
        self.email = user.email
        self.about = user.about
        self.registered = user.registered
        self.tags = user.tags.joined(separator: ",")

        if let managedObjectContext = managedObjectContext {
            user.friends.map { friend -> CachedFriend in
                let cachedFriend = CachedFriend(context: managedObjectContext)
                cachedFriend.set(friend: friend)
                cachedFriend.user = self
                return cachedFriend
            }.forEach { cachedFriend in
                addToFriends(cachedFriend)
            }
        }
    }
}
