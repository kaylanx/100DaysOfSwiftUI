//
//  FileManager+Codable.swift
//  PhotoNames
//
//  Created by Andy Kayley on 01/09/2022.
//

import Foundation

extension FileManager {

    enum CodableError: Error {
        case failedToLocateFile(String)
        case failedToEncode(String, String)
        case failedToLoad(String)
        case failedToDecode(String)
    }

    static func encode<T: Encodable>(value: T, to file: String) throws {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let url = paths.first?.appendingPathComponent(file) else {
            throw CodableError.failedToLocateFile(file)
        }

        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(value) else {
            throw CodableError.failedToEncode("\(value)", file)
        }
        try data.write(to: url, options: [.atomic])
    }

    static func decode<T: Decodable>(_ file: String) throws -> T {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let url = paths.first?.appendingPathComponent(file) else {
            throw CodableError.failedToLocateFile(file)
        }

        guard let data = try? Data(contentsOf: url) else {
            throw CodableError.failedToLoad(file)
        }

        guard let loaded = try? JSONDecoder().decode(T.self, from: data) else {
            throw CodableError.failedToDecode(file)
        }

        return loaded
    }
}
