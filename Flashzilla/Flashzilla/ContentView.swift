//
//  ContentView.swift
//  Flashzilla
//
//  Created by Andy Kayley on 20/09/2022.
//

import SwiftUI

extension View {
    func stacked(at card: Card, in cards: [Card]) -> some View {
        let offset = Double(cards.count - (cards.firstIndex(of: card) ?? 0))
        return self.offset(x: 0, y: offset * 10)
    }
}

struct ContentView: View {

    @Environment(\.accessibilityDifferentiateWithoutColor) private var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) private var voiceOverEnabled
    @Environment(\.scenePhase) private var scenePhase
    @State private var isShowingEditScreen = false
    @State private var isActive = true
    @State private var timeRemaining = 100

    @StateObject private var viewModel = CardViewModel()

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var accessibilityFeaturesEnabled: Bool {
        differentiateWithoutColor || voiceOverEnabled
    }

    private func removeCardButton(
        systemImageName: String,
        accessibilityLabel: String,
        accessibilityHint: String,
        action: (() -> Void)?
    ) -> some View {
        Button {
            action?()
        } label: {
            styledImage(systemName: systemImageName)
        }
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint(accessibilityHint)
    }

    private func styledImage(systemName: String) -> some View {
        Image(systemName: systemName)
            .padding()
            .background(.black.opacity(0.7))
            .clipShape(Circle())
    }

    var body: some View {
        ZStack {
            Image(decorative: "background")
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
                    ForEach(viewModel.cards) { card in
                        CardView(card: card) { answeredCorrectly in
                            if answeredCorrectly {
                                answerCorrect(forCard: card)
                            } else {
                                answerIncorrect(forCard: card)
                            }
                        }
                        .stacked(at: card, in: viewModel.cards)
                        .allowsHitTesting(isTop(card: card))
                        .accessibilityHidden(!isTop(card: card))
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                if viewModel.cards.isEmpty || timeRemaining == 0 {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }

            VStack {
                HStack {
                    Spacer()

                    Button {
                        isShowingEditScreen = true
                    } label: {
                        styledImage(systemName: "plus.circle")
                    }
                }
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()

            uiForAccessibility
        }
        .onReceive(timer) { time in
            guard isActive else { return }

            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if viewModel.cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(
            isPresented: $isShowingEditScreen,
            onDismiss: resetCards,
            content: EditCards.init
        )
        .onAppear(perform: resetCards)
    }

    @ViewBuilder
    private var uiForAccessibility: some View {
        if accessibilityFeaturesEnabled {
            VStack {
                Spacer()
                HStack {
                    removeCardButton(
                        systemImageName: "xmark.circle",
                        accessibilityLabel: "Wrong",
                        accessibilityHint: "Mark your answer as being incorrect"
                    ) {
                        answerIncorrect(forCard: topCard())
                    }
                    Spacer()
                    removeCardButton(
                        systemImageName: "checkmark.circle",
                        accessibilityLabel: "Correct",
                        accessibilityHint: "Mark your answer as being correct"
                    ) {
                        answerCorrect(forCard: topCard())
                    }
                }
                .foregroundColor(.white)
                .font(.largeTitle)
                .padding()
            }
        } else {
            EmptyView()
        }
    }

    private func answerCorrect(forCard card: Card) {
        withAnimation {
            remove(card: card)
            if viewModel.cards.isEmpty {
                isActive = false
            }
        }
    }

    private func answerIncorrect(forCard card: Card) {
        withAnimation {
            remove(card: card)
            reAdd(card: card)
        }
    }

    private func isTop(card: Card) -> Bool {
        topCard() == card
    }

    private func topCard() -> Card {
        viewModel.cards.last!
    }

    private func remove(card: Card) {
        viewModel.cards.removeAll { $0 == card }
    }

    private func reAdd(card: Card) {
        viewModel.cards.insert(card, at: 0)
    }

    private func resetCards() {
        timeRemaining = 100
        isActive = true
        viewModel.loadData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
