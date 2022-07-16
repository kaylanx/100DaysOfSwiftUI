//
//  UserRepository.swift
//  FriendFace
//
//  Created by Andy Kayley on 06/07/2022.
//

import Foundation

struct RemoteUserRepository: UserRepository {
    
    private let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!

    func getUsers() async throws -> [User] {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let (data, _) = try await URLSession(configuration: config).data(from: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode([User].self, from: data)
    }
}
