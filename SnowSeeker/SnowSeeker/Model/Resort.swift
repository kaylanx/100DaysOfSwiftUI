//
//  Resort.swift
//  SnowSeeker
//
//  Created by Andy Kayley on 27/10/2022.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    let defaultOrder: Int?

    var order: Int {
        defaultOrder ?? 0
    }

    var facilityTypes: [Facility] {
        facilities.map(Facility.from)
    }

    static func resort(_ resort: Resort, withOrder order: Int) -> Resort{
        Resort(
            id: resort.id,
            name: resort.name,
            country: resort.country,
            description: resort.description,
            imageCredit: resort.imageCredit,
            price: resort.price,
            size: resort.size,
            snowDepth: resort.snowDepth,
            elevation: resort.elevation,
            runs: resort.runs,
            facilities: resort.facilities,
            defaultOrder: order
        )
    }
}
