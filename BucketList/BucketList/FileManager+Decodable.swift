//
//  FileManager+Decodable.swift
//  BucketList
//
//  Created by Andy Kayley on 25/07/2022.
//

import Foundation

extension FileManager {
    static func decode<T: Codable>(_ file: String) -> T {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let url = paths.first?.appendingPathComponent(file) else {
            fatalError("Failed to locate \(file) in user document directory")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from Bundle")
        }

        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to parse json from file \(file)")
        }

        return loaded
    }
}
