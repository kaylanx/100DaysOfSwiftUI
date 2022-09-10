//
//  User.swift
//  Hot Prospects
//
//  Created by Andy Kayley on 10/09/2022.
//

import SwiftUI

enum  LearningEnvironmentObjects {
    @MainActor
    class User: ObservableObject {
        @Published var name = "Taylor Swift"
    }

    struct EditView: View {
        @EnvironmentObject private var user: User

        var body: some View {
            TextField("Name", text: $user.name)
        }
    }

    struct DisplayView: View {
        @EnvironmentObject private var user: User

        var body: some View {
            Text(user.name)
        }
    }

    struct ContentView: View {
        @StateObject private var user = User()

        var body: some View {
            VStack {
                EditView()
                DisplayView()
            }
            .environmentObject(user)
        }
    }
}
