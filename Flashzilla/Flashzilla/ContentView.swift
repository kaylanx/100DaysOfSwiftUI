//
//  ContentView.swift
//  Flashzilla
//
//  Created by Andy Kayley on 20/09/2022.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}

struct ContentView: View {

    @Environment(\.accessibilityDifferentiateWithoutColor) private var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) private var voiceOverEnabled
    @Environment(\.scenePhase) private var scenePhase
    @State private var isActive = true
    @State private var cards = Array<Card>(repeating: Card.example, count: 10)
    @State private var timeRemaining = 100
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var accessibilityFeaturesEnabled: Bool {
        differentiateWithoutColor || voiceOverEnabled
    }

    private func removeCardButton(
        systemImageName: String,
        accessibilityLabel: String,
        accessibilityHint: String
    ) -> some View {
        Button {
            withAnimation {
                removeCard(at: cards.count - 1)
            }
        } label: {
            Image(systemName: systemImageName)
                .padding()
                .background(.black.opacity(0.7))
                .clipShape(Circle())
        }
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint(accessibilityHint)
    }

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())

                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]) {
                            withAnimation {
                                removeCard(at: index)
                                if cards.isEmpty {
                                    isActive = false
                                }
                            }
                        }
                        .stacked(at: index, in: cards.count)
                        .allowsHitTesting(isTopCard(at: index))
                        .accessibilityHidden(!isTopCard(at: index))
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }

            if accessibilityFeaturesEnabled {
                VStack {
                    Spacer()
                    HStack {
                        removeCardButton(
                            systemImageName: "xmark.circle",
                            accessibilityLabel: "Wrong",
                            accessibilityHint: "Mark your answer as being incorrect"
                        )
                        Spacer()
                        removeCardButton(
                            systemImageName: "checkmark.circle",
                            accessibilityLabel: "Correct",
                            accessibilityHint: "Mark your answer as being correct"
                        )
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }

            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
    }

    private func isTopCard(at index: Int) -> Bool {
        index == cards.count - 1
    }

    private func removeCard(at index: Int) {
        guard index >= 0 else { return }
        cards.remove(at: index)
    }

    private func resetCards() {
        cards = [Card](repeating: Card.example, count: 10)
        timeRemaining = 100
        isActive = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
