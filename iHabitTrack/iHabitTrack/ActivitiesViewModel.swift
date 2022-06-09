//
//  Activities.swift
//  iHabitTrack
//
//  Created by Andy Kayley on 07/06/2022.
//

import Foundation

class ActivitiesViewModel: ObservableObject {
    @Published var activities = [Activity]()

    init() {
        add(activity: Activity(name: "Dancing", numberOfTimesCompleted: 0))
        add(activity: Activity(name: "Walking", numberOfTimesCompleted: 7))
        add(activity: Activity(name: "Going to the gym", numberOfTimesCompleted: 5))
        add(activity: Activity(name: "Drinking water", numberOfTimesCompleted: 6))
        add(activity: Activity(name: "Catching Pokémon", numberOfTimesCompleted: 929))
    }

    func add(activity: Activity) {
        activities.append(activity)
    }
}
