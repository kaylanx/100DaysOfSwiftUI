//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Andy Kayley on 23/03/2022.
//

import SwiftUI

struct FlagImage: View {

    let countryName: String

    var body: some View {
        Image(countryName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {

    private let numberOfQuestions = 8

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var currentQuestion = 0
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreDescription = ""
    @State private var alertButtonText = "Continue"

    @State private var animationAmount = [0.0, 0.0, 0.0]


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

                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation {
                                animationAmount[number] += 360
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                flagTapped(number)
                            }
                        } label: {
                            FlagImage(countryName: countries[number])
                        }
                        .rotation3DEffect(
                            .degrees(animationAmount[number]),
                            axis: (x: 0, y: 1, z: 0)
                        )
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                Spacer()
                Text("Score \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button(alertButtonText, action: askQuestion)
        } message: {
            Text(scoreDescription)
        }
    }

    private func flagTapped(_ number: Int) {
        alertButtonText = "Continue"
        if number == correctAnswer {
            scoreTitle = "Correct"
            score = score + 1
            scoreDescription = "Your score is \(score)"
        } else {
            scoreTitle = "Wrong"
            scoreDescription = "That's the flag of \(countries[number])"
        }

        if currentQuestion == numberOfQuestions {
            alertButtonText = "Start again"
            scoreTitle = "Quiz Over"
            scoreDescription = "Your final score is \(score)"
            currentQuestion = 0
            score = 0
        }

        showingScore = true
    }

    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        currentQuestion = currentQuestion + 1
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
