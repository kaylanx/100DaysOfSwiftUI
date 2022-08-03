//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Andy Kayley on 23/03/2022.
//

import SwiftUI

struct FlagImage: View {

    let countryName: String

    private let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]

    var body: some View {
        Image(countryName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
            .accessibilityLabel(labels[countryName, default: "Unknown flag"])
    }
}

struct ContentView: View {

    private let numberOfQuestions = 8

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()


    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var currentQuestion = 0
    @State private var score = 0
    @State private var showingScore = false
    //    @State private var scoreTitle = ""
    //    @State private var scoreDescription = ""
    //    @State private var alertButtonText = "Continue"

    @State private var rotationAnimationAmount = [0.0, 0.0, 0.0]
    @State private var fadeAnimationAmount = [1.0, 1.0, 1.0]

    private static let guessTheFlagText = "Guess the flag"
    private static let tapTheFlagOf = "Tap the flag of"


    @State private var screenTitle = guessTheFlagText
    @State private var screenFooter = "Score 0"

    @State private var tapText = tapTheFlagOf


    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
                ],
                center: .top,
                startRadius: 200,
                endRadius: 700
            )
            .ignoresSafeArea()

            VStack {
                Spacer()

                Text(screenTitle)
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .animation(.easeInOut, value: showingScore)

                VStack(spacing: 15) {
                    VStack {
                        Text(tapText)
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                            .animation(.easeInOut, value: tapText)

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .animation(.easeInOut, value: correctAnswer)

                    }
                    .accessibilityElement()
                    .accessibilityLabel("\(ContentView.guessTheFlagText) of \(countries[correctAnswer])")

                    ForEach(0..<3) { number in
                        Button {
                            withAnimation {
                                for i in 0..<3 {
                                    if i != number {
                                        fadeAnimationAmount[i] = 0.25
                                    }
                                }
                                rotationAnimationAmount[number] += 360
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                flagTapped(number)
                            }
                        } label: {
                            FlagImage(countryName: countries[number])
                        }
                        .opacity(fadeAnimationAmount[number])
                        .rotation3DEffect(
                            .degrees(rotationAnimationAmount[number]),
                            axis: (x: 0, y: 1, z: 0)
                        )
                        .disabled(showingScore)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                Spacer()
                Text(screenFooter)
                    .foregroundColor(.white)
                    .font(.title.bold())
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .animation(.linear, value: screenFooter)
                Spacer()
            }
            .padding()
        }
        .onTapGesture {
            if showingScore {
                askQuestion()
                showingScore = false
            }
        }
    }

    private func flagTapped(_ number: Int) {
        if number == correctAnswer {
            screenTitle = "Correct"
            score = score + 1
            screenFooter = "Score \(score)"
        } else {
            screenTitle = "Wrong"
            screenFooter = "That's the flag of \(countries[number])"
        }

        tapText = "Tap to continue"

        if currentQuestion == numberOfQuestions {
            //            alertButtonText = "Start again"
            screenTitle = "Quiz Over"
            //            scoreDescription = "Your final score is \(score)"
            currentQuestion = 0
            score = 0
        }

        showingScore = true
    }

    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        tapText = ContentView.tapTheFlagOf
        currentQuestion = currentQuestion + 1
        screenTitle = ContentView.guessTheFlagText
        fadeAnimationAmount = [1.0, 1.0, 1.0]

        screenFooter = "Score \(score)"

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
