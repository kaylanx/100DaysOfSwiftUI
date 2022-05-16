//
//  Mission.swift
//  Moonshot
//
//  Created by Andy Kayley on 12/05/2022.
//

import Foundation

struct Mission: Codable, Identifiable {

    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String

    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }

    var shortFormattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? ""
    }

    var longFormattedLaunchDate: String {
        launchDate?.formatted(date: .long, time: .omitted) ?? ""
    }
}
