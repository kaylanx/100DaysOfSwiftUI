//
//  File.swift
//  PhotoNames
//
//  Created by Andy Kayley on 10/08/2022.
//

import Foundation

struct NamedPhoto: Identifiable, Codable {
    var id = UUID()
    let name: String
    let location: PhotoLocation?

    var imageUrl: URL {
        FileManager.documentsDirectory.appendingPathComponent(id.uuidString)
    }
}

extension NamedPhoto: Comparable {
    static func < (lhs: NamedPhoto, rhs: NamedPhoto) -> Bool {
        lhs.name < rhs.name
    }
}
