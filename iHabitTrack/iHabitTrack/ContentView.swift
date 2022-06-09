//
//  ContentView.swift
//  iHabitTrack
//
//  Created by Andy Kayley on 07/06/2022.
//

import SwiftUI

struct ActivityCountStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding(7)
            .background(.purple)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func activityCountStyle() -> some View {
        modifier(ActivityCountStyle())
    }
}

struct ContentView: View {

    @StateObject var viewModel = ActivitiesViewModel()
    @State private var showingAddActivity = false

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Activities")) {
                    ForEach(viewModel.activities) { activity in
                        NavigationLink(
                            destination: ActivityDetailsView(
                                viewModel: viewModel,
                                selectedActivity: activity
                            )
                        ) {
                            HStack {
                                Text("\(activity.name)")
                                Spacer()
                                VStack {
                                    Text("\(activity.numberOfTimesCompleted)")
                                        .activityCountStyle()
                                    Text("times")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("iHabit")
            .toolbar {
                Button {
                    showingAddActivity = true
                } label: {
                    Image(systemName: "plus")
                }

            }
            .sheet(isPresented: $showingAddActivity) {
                AddActivityView(viewModel: viewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
