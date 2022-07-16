//
//  CachedFriend+ModelMapping.swift
//  FriendFace
//
//  Created by Andy Kayley on 16/07/2022.
//


import Foundation

extension CachedFriend {

    func toFriend() -> Friend {
        Friend(
            id: id ?? "Unknown Friend Id",
            name: name ?? "Unknown Friend Name"
        )
    }

    func set(friend: Friend) {
        self.id = friend.id
        self.name = friend.name
    }
}
