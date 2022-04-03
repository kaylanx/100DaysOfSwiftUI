//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Andy Kayley on 02/04/2022.
//

import SwiftUI



//  🪨 Rock
//  📰 Paper
//  ✂️ Scissors

enum Choice: String, CaseIterable {
  case rock = "🪨"
  case paper = "📰"
  case scissors = "✂️"
  
  func canBeat() -> Choice {
    switch self {
      case .rock:
        return .scissors
      case .paper:
        return .rock
      case .scissors:
        return .paper
    }
  }
}

enum Result: String, CaseIterable {
  case win = "Win"
  case lose = "Lose"
}

struct ContentView: View {
  
  @State private var playersChoice: Choice?
  @State private var playerMust = Result.allCases.randomElement() ?? .win
  @State private var computerChoice = Choice.allCases.randomElement() ?? .rock
  
  @State private var showingAlert = false
  
  private func didPlayerWin() -> Bool {
    switch playerMust {
      case .win:
        return playersChoice?.canBeat() == computerChoice
      case .lose:
        return playersChoice?.canBeat() != computerChoice
    }
  }
  
  var body: some View {
    VStack {
      Text("I choose \(computerChoice.rawValue)")
      Text("You must \(playerMust.rawValue)")
      VStack {
        Text("Your choice")
        HStack {
          ForEach(Choice.allCases, id: \.self) { choice in
            Button {
              playersChoice = choice
              showingAlert = true
            } label: {
              Text(choice.rawValue)
            }
            .padding()
            .border(.secondary, width: 1.0)
          }
        }
      }
      .padding()
      .border(.mint, width: 1.0)
    }
    .alert(didPlayerWin() ? "Hurray" : "Unlucky" , isPresented: $showingAlert) {
      Button("OK", role: .cancel) {
        playerMust = Result.allCases.randomElement() ?? .win
        computerChoice = Choice.allCases.randomElement() ?? .rock
        playersChoice = nil
      }
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
