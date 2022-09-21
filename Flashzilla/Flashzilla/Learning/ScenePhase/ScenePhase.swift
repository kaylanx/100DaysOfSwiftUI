//
//  ScenePhase.swift
//  Flashzilla
//
//  Created by Andy Kayley on 21/09/2022.
//

import SwiftUI

enum ScenePhase {
    struct ContentView: View {

        @Environment(\.scenePhase) var scenePhase

        var body: some View {
            Text("Hello, World!")
                .padding()
                .onChange(of: scenePhase) { newPhase in
                    switch newPhase {
                        case .background:
                            print("Background")
                        case .inactive:
                            print("Inactive")
                        case .active:
                            print("Active")
                        @unknown default:
                            print("Unknown phase")
                    }
                }
        }
    }

    struct ScenePhase_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
