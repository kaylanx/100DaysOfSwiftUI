//
//  PhotoLocationView.swift
//  PhotoNames
//
//  Created by Andy Kayley on 07/09/2022.
//

import SwiftUI
import MapKit

struct PhotoLocationView: View {

    let location: PhotoLocation
    @State private var mapRegion: MKCoordinateRegion

    init(location: PhotoLocation) {
        self.location = location
        _mapRegion = State(
            wrappedValue: MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.5,
                    longitudeDelta: 0.5
                )
            )
        )
    }

    var body: some View {
        Map(
            coordinateRegion: .constant(mapRegion),
            annotationItems: [location]
        ) { location in
            MapMarker(coordinate: location.coordinate)
        }
    }
}

struct PhotoLocationView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoLocationView(
            location: PhotoLocation(
                id: UUID(),
                latitude: 51.5,
                longitude: -0.12
            )
        )
    }
}
