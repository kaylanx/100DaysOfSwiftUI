//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Andy Kayley on 30/03/2022.
//

import SwiftUI

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
}

struct ContentView: View {
  
  var body: some View {
    Color.blue
      .frame(width:200, height: 200)
      .watermarked(with: "poop")
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
