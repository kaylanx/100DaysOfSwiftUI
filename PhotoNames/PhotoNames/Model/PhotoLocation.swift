//
//  PhotoLocation.swift
//  PhotoNames
//
//  Created by Andy Kayley on 06/09/2022.
//

import Foundation

struct PhotoLocation: Equatable, Codable, Identifiable {
    var id: UUID
    let latitude: Double
    let longitude: Double
}
