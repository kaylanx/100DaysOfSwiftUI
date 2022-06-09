//
//  Activities.swift
//  iHabitTrack
//
//  Created by Andy Kayley on 07/06/2022.
//

import Foundation

class ActivitiesViewModel: ObservableObject {

    @Published var activities = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "activities")
            }
        }
    }

    init() {
        if let savedActivities = UserDefaults.standard.data(forKey: "activities") {
            if let decodedItems = try? JSONDecoder().decode([Activity].self, from: savedActivities) {
                activities = decodedItems
                return
            } else {
                activities = []
            }
        } else {
            activities = []
        }
    }

    func add(activity: Activity) {
        activities.append(activity)
    }

    func complete(activity: Activity) -> Activity {
        if let index = activities.firstIndex(of: activity) {
            var activityToUpdate = activities[index]
            activityToUpdate.numberOfTimesCompleted += 1
            activities[index] = activityToUpdate
            return activityToUpdate
        }
        return activity
    }
}
