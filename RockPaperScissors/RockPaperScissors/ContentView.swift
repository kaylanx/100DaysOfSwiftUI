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
  
  func toggle() -> Result {
    switch self {
      case .win: return .lose
      case .lose: return .win
    }
  }
}

struct ContentView: View {
  
  @State private var playersChoice: Choice?
  @State private var playerMust = Result.allCases.randomElement() ?? .win
  @State private var computerChoice = Choice.allCases.randomElement() ?? .rock
  @State private var showingAlert = false
  @State private var showingEndGameAlert = false
  @State private var playerScore = 0
  @State private var turnNumber = 0
  
  private var didPlayerWin: Bool {
    guard playersChoice != computerChoice else {
      return false
    }
    switch playerMust {
      case .win:
        return playersChoice?.canBeat() == computerChoice
      case .lose:
        return playersChoice?.canBeat() != computerChoice
    }
  }
  
  var body: some View {
    VStack {
      Text("I choose")
      Text(computerChoice.rawValue)
        .font(.system(size: 75))
      Text("You must \(playerMust.rawValue)")
      VStack {
        Text("Your choice")
        HStack {
          ForEach(Choice.allCases, id: \.self) { choice in
            Button {
              playersChoice = choice
              playerScore = didPlayerWin ? playerScore + 1 : playerScore - 1
              turnNumber = turnNumber + 1
              if turnNumber == 10 {
                showingEndGameAlert = true
              } else {
                showingAlert = true
              }
              
            } label: {
              Text(choice.rawValue)
                .font(.system(size: 75))
            }
            .padding()
            .border(.secondary, width: 1.0)
          }
        }
      }
      .padding()
      Text("Your score: \(playerScore)")
      
    }
    .alert(didPlayerWin ? "Hurray" : "Unlucky" , isPresented: $showingAlert) {
      Button("OK", role: .cancel) {
        playerMust = playerMust.toggle()
        computerChoice = Choice.allCases.randomElement() ?? .rock
        playersChoice = nil
      }
    }
    .alert("Game finished" , isPresented: $showingEndGameAlert) {
      Text("You scored \(playerScore) point(s)")
      Button("OK", role: .cancel) {
        playerScore = 0
        playerMust = Result.allCases.randomElement() ?? .win
        computerChoice = Choice.allCases.randomElement() ?? .rock
        playersChoice = nil
        turnNumber = 0
      }
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
