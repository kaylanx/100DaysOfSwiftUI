//
//  ActivityDetailsView.swift
//  iHabitTrack
//
//  Created by Andy Kayley on 09/06/2022.
//

import SwiftUI

struct ActivityDetailsView: View {

    @StateObject var viewModel: ActivitiesViewModel
    @State var selectedActivity: Activity

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text("Times completed")
                Spacer()
                Text("\(selectedActivity.numberOfTimesCompleted)")
            }
            .padding(.bottom)
            Button("Complete activity") {
                selectedActivity = viewModel.complete(activity: selectedActivity)
            }
            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle(selectedActivity.name)
    }
}

struct ActivityDetailsView_Previews: PreviewProvider {

    static var previews: some View {
        ActivityDetailsView(viewModel: ActivitiesViewModel(), selectedActivity: Activity(name: "Boogie", numberOfTimesCompleted: 4))
    }
}
