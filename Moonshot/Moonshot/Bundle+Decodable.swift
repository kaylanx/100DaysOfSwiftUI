//
//  Bundle+Decodable.swift
//  Moonshot
//
//  Created by Andy Kayley on 12/05/2022.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in Bundle")
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
