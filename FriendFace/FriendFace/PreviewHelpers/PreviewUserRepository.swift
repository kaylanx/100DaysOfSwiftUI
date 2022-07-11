//
//  PreviewUserRepository.swift
//  FriendFace
//
//  Created by Andy Kayley on 08/07/2022.
//

import Foundation

struct PreviewUserRepository: UserProviding {

    static var users = [
        User(
            id: "50a48fa3-2c0f-4397-ac50-64da464f9954",
            isActive: true,
            name: "John Appleseed",
            age: 36,
            company: "Imkan",
            email: "alfordrodriguez@imkan.com",
            address: "907 Nelson Street, Cotopaxi, South Dakota, 5913",
            about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.",
            registered: Date(),
            tags: [
                "cillum",
                "consequat",
                "deserunt",
                "nostrud",
                "eiusmod",
                "minim",
                "tempor"
            ],
            friends: [
                Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed1", name: "Hawkins Patel"),
                Friend(id: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf2", name: "Jewel Sexton"),
                Friend(id: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf3", name: "Berger Robertson"),
                Friend(id: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf4", name: "Hess Ford"),
                Friend(id: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf5", name: "Bonita White"),
                Friend(id: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf6", name: "Sheryl Robinson"),
                Friend(id: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf7", name: "Karin Collins"),
                Friend(id: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf8", name: "Pace English"),
                Friend(id: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf9", name: "Pauline Dawson"),
                Friend(id: "0c395a95-57e2-4d53-b4f6-9b9e46a32c10", name: "Russo Carlson"),
                Friend(id: "0c395a95-57e2-4d53-b4f6-9b9e46a32c11", name: "Josefina Rivas")
            ]
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

    func getUsers() async -> [User] {
        PreviewUserRepository.users
    }
}
