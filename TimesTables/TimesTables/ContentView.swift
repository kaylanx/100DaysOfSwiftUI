//
//  ContentView.swift
//  TimesTables
//
//  Created by Andy Kayley on 27/04/2022.
//

/*

 Your goal is to build an “edutainment” app for kids to help them practice
 multiplication tables – “what is 7 x 8?” and so on. Edutainment apps are educational
 at their code, but ideally have enough playfulness about them to make kids want to
 play.

 Breaking it down:

 The player needs to select which multiplication tables they want to practice. This
 could be pressing buttons, or it could be an “Up to…” stepper, going from 2 to 12.

 The player should be able to select how many questions they want to be asked: 5, 10,
 or 20.

 You should randomly generate as many questions as they asked for, within the
 difficulty range they asked for.


 How many questions?
 Which tables?  2 to 12 ( or random? )

 */

import SwiftUI

struct Question {
    let operand = "*"
    let lhs: Int
    let rhs: Int
    var answer: Int {
        lhs * rhs
    }
}

struct ContentView: View {

    @State private var questions = [Question]()
    @State private var currentQuestion = 0
    private let numberOfQuestionsOption = [5, 10, 20]
    @State private var tablesToPractice = 2
    @State private var numberOfQuestionsSelected = 5
    @State private var gameStarted = false
    private let numberRange = 0...12
    @State private var currentAnswer = ""

    @State private var answer = ""

    var body: some View {
        if !gameStarted {
            VStack {
                Stepper("Which tables do you wish to practice?",
                        value: $tablesToPractice,
                        in: 2...12)
                Text("\(tablesToPractice) times table")
                HStack {
                    Text("How many questions would you like?")
                    Picker("How many questions would you like?", selection: $numberOfQuestionsSelected) {
                        ForEach(numberOfQuestionsOption, id: \.self) { numberOfQuestions in
                            Text("\(numberOfQuestions)")
                        }
                    }
                }
                Button("Start Game") {
                    gameStarted = true
                    for _ in 0..<numberOfQuestionsSelected {
                        questions.append(Question(lhs: tablesToPractice, rhs: numberRange.randomElement() ?? 0))
                    }
                }
            }
            .padding()
        } else {
            VStack {
                Text("Question \(currentQuestion + 1)")
                Text("\(questions[currentQuestion].lhs) x \(questions[currentQuestion].rhs) = ?")
                TextField("Answer", text: $currentAnswer)
                if answer == "" {
                    Button("Check") {
                        if currentAnswer == "\(questions[currentQuestion].answer)" {
                            answer = "Correct"
                        } else {
                            answer = "Incorrect"
                        }
                    }
                }
                else  {
                    if currentQuestion == numberOfQuestionsSelected - 1 {
                        Text("\(answer) - tap to start again")
                    } else {
                        Text("\(answer) - tap to continue")
                    }
                }
            }
            .padding()
            .onTapGesture {
                if answer != "" {
                    answer = ""
                    currentAnswer = ""
                    if currentQuestion < numberOfQuestionsSelected - 1 {
                        currentQuestion += 1
                    } else if currentQuestion == numberOfQuestionsSelected - 1 {
                        questions.removeAll()
                        currentQuestion = 0
                        gameStarted = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
