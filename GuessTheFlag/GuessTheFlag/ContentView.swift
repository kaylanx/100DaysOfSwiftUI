//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Andy Kayley on 23/03/2022.
//

import SwiftUI

struct ContentView: View {
  
  @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)
  
  @State private var showingScore = false
  @State private var scoreTitle = ""
  
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
              flagTapped(number)
            } label: {
              Image(countries[number])
                .renderingMode(.original)
                .clipShape(Capsule())
                .shadow(radius: 5)
            }
          }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
        Spacer()
        Spacer()
        Text("Score ???")
          .foregroundColor(.white)
          .font(.title.bold())
        Spacer()
      }
      .padding()
    }
    .alert(scoreTitle, isPresented: $showingScore) {
      Button("Continue", action: askQuestion)
    } message: {
      Text("Your score is ???")
    }
  }
  
  private func flagTapped(_ number: Int) {
    scoreTitle = number == correctAnswer ? "Correct" : "Wrong"
    showingScore = true
  }
  
  private func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
