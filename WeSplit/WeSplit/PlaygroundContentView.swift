//
//  ContentView.swift
//  WeSplit
//
//  Created by Andy Kayley on 14/03/2022.
//

import SwiftUI

struct PlayGroundContentView: View {
  @State private var tapCount = 0
  @State private var name = ""
  
  private let students = ["Harry", "Hermione", "Ron"]
  @State private var selectedStudent = "Harry"
  
  var body: some View {
    textFieldFormView
    tapCountView
    navView
    forEachView
  }
  
  private var forEachView: some View {
    NavigationView {
      Form {
        Picker("Select your student", selection: $selectedStudent) {
          ForEach(students, id: \.self) { name in
            Text("\(name)")
          }
        }
      }
    }
  }
  
  private var textFieldFormView: some View {
    Form {
      TextField("Enter your name", text: $name)
      Text("Your name is \(name)")
    }
  }
  
  private var tapCountView: some View {
    Button("Tap count: \(tapCount)") {
      tapCount += 1
    }
  }
  
  private var navView: some View {
    NavigationView {
      Form {
        Section {
          Text("booya, world!")
        }
        Section {
          Text("booya, world!")
          Text("booya, world!")
        }
      }
      .navigationTitle("SwiftUI")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

struct PlayGroundContentView_Previews: PreviewProvider {
  static var previews: some View {
    PlayGroundContentView()
  }
}
