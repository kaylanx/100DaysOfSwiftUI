//
//  Stru t.swift
//  iHabitTrack
//
//  Created by Andy Kayley on 07/06/2022.
//

import Foundation

struct Activity: Identifiable, Equatable, Codable {
    let id: UUID
    let name: String
    var numberOfTimesCompleted: Int

    init(id: UUID = UUID(), name: String, numberOfTimesCompleted: Int) {
        self.id = id
        self.name = name
        self.numberOfTimesCompleted = numberOfTimesCompleted
    }
}
