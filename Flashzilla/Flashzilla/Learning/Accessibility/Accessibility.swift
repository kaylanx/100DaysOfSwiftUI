//
//  Accessibility.swift
//  Flashzilla
//
//  Created by Andy Kayley on 21/09/2022.
//

import SwiftUI

enum Accessibility {

    struct DifferentiateWithoutColor: View {
        @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

        var body: some View {
            HStack {
                if differentiateWithoutColor {
                    Image(systemName: "checkmark.circle")
                }

                Text("Success")
            }
            .padding()
            .background(differentiateWithoutColor ? .black : .green)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
    }

    struct ReduceMotion: View {
        @Environment(\.accessibilityReduceMotion) var reduceMotion
        @State private var scale = 1.0

        var body: some View {
            Text("Hello world!")
                .scaleEffect(scale)
                .onTapGesture {
                    if reduceMotion {
                        scale *= 1.5
                    } else {
                        withAnimation {
                            scale *= 1.5
                        }
                    }
                }
        }
    }

    struct ReduceMotion2: View {
        @State private var scale = 1.0

        var body: some View {
            Text("Hello world!")
                .scaleEffect(scale)
                .onTapGesture {
                    withOptionalAnimation {
                        scale *= 1.5
                    }
                }
        }

        private func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
            if UIAccessibility.isReduceMotionEnabled {
                return try body()
            } else {
                return try withAnimation(animation, body)
            }
        }
    }

    struct ReduceTransparency: View {

        @Environment(\.accessibilityReduceTransparency) var reduceTransparency

        var body: some View {
            Text("Hello, world!")
                .padding()
                .background(reduceTransparency ? .black : .black.opacity(0.5))
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
    }

    struct Accessibility_Previews: PreviewProvider {
        static var previews: some View {
            DifferentiateWithoutColor()
            ReduceMotion()
            ReduceMotion2()
        }
    }
}
