//
//  NavigationLinkView.swift
//  Moonshot
//
//  Created by Andy Kayley on 11/05/2022.
//

import SwiftUI

struct NavigationLinkView: View {
    var body: some View {
        NavigationView {
            List(0..<100) { row in
                NavigationLink {
                    Text("Detail \(row)")
                } label: {
                    Text("Hello, \(row)!")
                        .padding()
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}

struct NavigationLinkView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLinkView()
    }
}
