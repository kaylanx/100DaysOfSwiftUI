//
//  PreviewUserRepository.swift
//  FriendFace
//
//  Created by Andy Kayley on 08/07/2022.
//

import Foundation

struct PreviewUserRepository: UserProviding {

    func getUsers() async -> [User] {
        [
            User(
                id: "123",
                isActive: true,
                name: "John Appleseed",
                age: 36,
                company: "",
                email: "",
                address: "",
                about: "",
                registered: Date(),
                tags: [],
                friends: []
            ),
            User(
                id: "456",
                isActive: false,
                name: "Leia Organa",
                age: 25,
                company: "",
                email: "",
                address: "",
                about: "",
                registered: Date(),
                tags: [],
                friends: []
            ),
        ]
    }
}
