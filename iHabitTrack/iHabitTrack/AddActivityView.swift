//
//  AddEditActivityView.swift
//  iHabitTrack
//
//  Created by Andy Kayley on 07/06/2022.
//

import SwiftUI

struct AddActivityView: View {

    @ObservedObject var viewModel: ActivitiesViewModel
    @Environment(\.dismiss) var dismiss

    @State private var name = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Activity Name", text: $name)
            }
            .navigationTitle("Add an activity")
            .toolbar {
                Button("Save") {
                    let activity = Activity(name: name, numberOfTimesCompleted: 0)
                    viewModel.add(activity: activity)
                    dismiss()
                }
            }
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(viewModel: ActivitiesViewModel())
    }
}
