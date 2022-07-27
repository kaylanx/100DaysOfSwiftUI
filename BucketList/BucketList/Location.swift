//
//  Location.swift
//  BucketList
//
//  Created by Andy Kayley on 27/07/2022.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }

    static func ==(lhs: Location, rhs: Location) -> Bool{
        lhs.id == rhs.id
    }
}
