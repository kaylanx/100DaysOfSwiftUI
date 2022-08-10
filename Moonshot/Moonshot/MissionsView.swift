//
//  MissionsView.swift
//  Moonshot
//
//  Created by Andy Kayley on 16/05/2022.
//

import SwiftUI

struct MissionsView: View {

    let missions: [Mission]
    let astronauts: [String: Astronaut]

    var body: some View {
        ForEach(missions) { mission in
            NavigationLink {
                MissionView(
                    mission: mission,
                    astronauts: astronauts
                )
            } label: {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                        .accessibilityHidden(true)
                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundColor(.white)

                        Text(mission.shortFormattedLaunchDate)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.5))

                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(.lightBackground)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.lightBackground)
            )
        }
    }
}

struct MissionsView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")

    static var previews: some View {
        MissionsView(
            missions: missions,
            astronauts: astronauts
        )
        .preferredColorScheme(.dark)
    }
}
