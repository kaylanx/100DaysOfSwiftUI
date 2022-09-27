//
//  CardView.swift
//  Flashzilla
//
//  Created by Andy Kayley on 22/09/2022.
//

import SwiftUI

struct CardView: View {

    let card: Card
    let onAnsweredCorrectly: ((Bool) -> Void)?

    private let feedback = UINotificationFeedbackGenerator()

    @Environment(\.accessibilityDifferentiateWithoutColor) private var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) private var voiceOverEnabled
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero

    private var isAnsweredCorrectly: Bool {
        offset.width > 0
    }

    private var isFullyRemoved: Bool {
        abs(offset.width) > 100
    }

    private var fillColor: Color {
        differentiateWithoutColor
        ? .white
        : .white
            .opacity(1 - Double(abs(offset.width / 50)))
    }

    private var backgroundColor: some View {
        differentiateWithoutColor
        ? nil
        : RoundedRectangle(cornerRadius: 25, style: .continuous)
            .fill(offset.width == 0 ? .white : offset.width > 0 ? .green : .red)
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(fillColor)
                .background(backgroundColor)
                .shadow(radius: 10)

            VStack {
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    feedback.prepare()
                }
                .onEnded { _ in
                    if isFullyRemoved {
                        feedback.notificationOccurred(isAnsweredCorrectly ? .success : .error)
                        if isAnsweredCorrectly == false {
                            offset = .zero
                        }
                        onAnsweredCorrectly?(isAnsweredCorrectly)
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            withAnimation {
                isShowingAnswer.toggle()
            }
        }
        .animation(.spring(), value: offset)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example) { answeredCorrectly in

        }.previewInterfaceOrientation(.landscapeLeft)
    }
}
