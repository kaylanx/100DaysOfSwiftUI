//
//  UserRepository.swift
//  FriendFace
//
//  Created by Andy Kayley on 15/07/2022.
//

protocol UserRepository {
    func getUsers() async throws -> [User]
}
