//
//  UserRepository.swift
//  FriendFace
//
//  Created by Andy Kayley on 06/07/2022.
//

import Foundation

protocol UserProviding {
    func getUsers() async -> [User]
}

struct UserRepository: UserProviding {

    private let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!

    func getUsers() async -> [User] {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode([User].self, from: data)
        } catch {
            // Error handling out of scope for this project.
            print(error)
        }
        return []
    }
}
