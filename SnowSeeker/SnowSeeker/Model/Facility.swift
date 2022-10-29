//
//  Facility.swift
//  SnowSeeker
//
//  Created by Andy Kayley on 29/10/2022.
//

import SwiftUI

enum Facility: String, Identifiable {
    case accommodation = "Accommodation"
    case beginners = "Beginners"
    case crossCountry = "Cross-country"
    case ecoFriendly = "Eco-friendly"
    case family = "Family"

    var id: String { rawValue }

    private var iconName: String {
        switch self {
            case .accommodation: return "house"
            case .beginners: return "1.circle"
            case .crossCountry: return "map"
            case .ecoFriendly: return "leaf.arrow.circlepath"
            case .family: return "person.3"
        }
    }

    var description: String {
        switch self {
            case .accommodation: return "This resort has popular on-site accommodation."
            case .beginners: return "This resort has lots of ski schools."
            case .crossCountry: return "This resort has many cross-country ski routes."
            case .ecoFriendly: return "This resort has won an award for environmental friendliness."
            case .family: return "This resort is popular with families."
        }
    }

    var icon: some View {
        Image(systemName: iconName)
            .accessibilityLabel(rawValue)
            .foregroundColor(.secondary)
    }

    static func from(_ facilityName: String) -> Facility {
        guard let facility = Facility(rawValue: facilityName) else {
            fatalError("\(facilityName) is not a valid facility")
        }
        return facility
    }
}
