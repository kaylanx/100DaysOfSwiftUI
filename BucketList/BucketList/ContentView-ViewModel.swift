//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Andy Kayley on 30/07/2022.
//

import CoreData
import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    @MainActor final class ViewModel: ObservableObject {

        @Published var mapRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 50,
                longitude: 0
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 25,
                longitudeDelta: 25
            )
        )

        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        @Published var authenticationError: Error?
        @Published var isShowingAuthenticationError = false

        private let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")

        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }

        func addLocation() {
            let newLocation = Location(
                id: UUID(),
                name: "New Location",
                description: "",
                latitude: mapRegion.center.latitude,
                longitude: mapRegion.center.longitude
            )

            locations.append(newLocation)
            save()
        }

        func update(location: Location) {
            guard let selectedPlace = selectedPlace else {
                return
            }

            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }

        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data: \(error.localizedDescription)")
            }
        }

        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places"
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    Task { @MainActor in
                        if success {
                            self.isUnlocked = true
                        } else {
                            self.authenticationError = authenticationError
                            self.isShowingAuthenticationError = true
                        }
                    }
                }
            } else {
                // no biometrics
            }
        }
    }
}
