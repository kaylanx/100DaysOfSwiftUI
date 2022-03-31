//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Andy Kayley on 30/03/2022.
//

import SwiftUI


// Create a custom ViewModifier (and accompanying View extension)
// that makes a view have a large, blue font suitable for prominent
// titles in a view.

struct ProminentTitle: ViewModifier {
  
  func body(content: Content) -> some View {
    content
      .font(.largeTitle)
      .foregroundColor(.blue)
  }
}

struct WaterMark: ViewModifier {
  
  var text: String
  
  func body(content: Content) -> some View {
    ZStack(alignment: .bottomTrailing) {
      content
      
      Text(text)
        .font(.caption)
        .foregroundColor(.white)
        .padding(5)
        .background(.black)
    }
  }
}

struct Title: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.largeTitle)
      .foregroundColor(.white)
      .padding()
      .background(.blue)
      .clipShape(RoundedRectangle(cornerRadius: 10))
  }
}

extension View {
  func titleStyle() -> some View {
    modifier(Title())
  }
  
  func watermarked(with text: String) -> some View {
    modifier(WaterMark(text: text))
  }
  
  func prominentitle() -> some View {
    modifier(ProminentTitle())
  }
}

struct ContentView: View {
  
  var body: some View {
    VStack {
      Color.blue
        .frame(width:200, height: 200)
        .watermarked(with: "poop")
      Text("Chicken")
        .prominentitle()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
