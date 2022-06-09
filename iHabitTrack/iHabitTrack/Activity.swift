//
//  Stru t.swift
//  iHabitTrack
//
//  Created by Andy Kayley on 07/06/2022.
//

import Foundation

struct Activity: Identifiable, Equatable {
    let id = UUID()
    let name: String
    var numberOfTimesCompleted: Int
}
