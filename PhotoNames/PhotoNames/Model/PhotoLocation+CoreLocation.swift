//
//  PhotoLocation+CoreLocation.swift
//  PhotoNames
//
//  Created by Andy Kayley on 06/09/2022.
//

import CoreLocation

extension PhotoLocation {
    init(location: CLLocationCoordinate2D) {
        self.id = UUID()
        self.latitude = location.latitude
        self.longitude = location.longitude
    }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }
}
