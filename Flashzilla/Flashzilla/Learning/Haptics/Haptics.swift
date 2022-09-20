//
//  Haptics.swift
//  Flashzilla
//
//  Created by Andy Kayley on 20/09/2022.
//

import SwiftUI
import CoreHaptics

enum Haptics {
    struct ContentView: View {

        @State private var engine: CHHapticEngine?

        var body: some View {
            VStack {
                Spacer()
                Text("Simple Success")
                    .onTapGesture(perform: simpleSuccess)
                Spacer()
                Text("Complex Success")
                    .onAppear(perform: prepareHaptics)
                    .onTapGesture(perform: complexSuccess)
                Spacer()
                Text("Error")
                    .onTapGesture(perform: simpleError)
                Spacer()
                Text("Warning")
                    .onTapGesture(perform: simpleWarning)
                Spacer()

            }
        }

        private func simpleSuccess() {
            notificationOccurred(feedbackType: .success)
        }

        private func complexSuccess() {
            // make sure that the device supports haptics
            guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
            var events = [CHHapticEvent]()

            for i in stride(from: 0, to: 1, by: 0.1) {
                let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
                let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
                let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
                events.append(event)
            }

            for i in stride(from: 0, to: 1, by: 0.1) {
                let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
                let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
                let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
                events.append(event)
            }

            // convert those events into a pattern and play it immediately
            do {
                let pattern = try CHHapticPattern(events: events, parameters: [])
                let player = try engine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            } catch {
                print("Failed to play pattern: \(error.localizedDescription).")
            }
        }

        private func simpleError() {
            notificationOccurred(feedbackType: .error)
        }

        private func simpleWarning() {
            notificationOccurred(feedbackType: .warning)
        }

        private func notificationOccurred(feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(feedbackType)
        }

        private func prepareHaptics() {
            guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

            do {
                engine = try CHHapticEngine()
                try engine?.start()
            } catch {
                print("There was an error creating the engine: \(error.localizedDescription)")
            }
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

