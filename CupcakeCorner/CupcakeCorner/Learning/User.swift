//
//  User.swift
//  CupcakeCorner
//
//  Created by Andy Kayley on 14/06/2022.
//

import Foundation

class User: ObservableObject, Codable {
    @Published var name = "Andy Kayley"

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }

    enum CodingKeys: CodingKey {
        case name
    }
}
