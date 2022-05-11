//
//  GridViews.swift
//  Moonshot
//
//  Created by Andy Kayley on 11/05/2022.
//

import SwiftUI

struct GridViews: View {
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120)),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }

            ScrollView(.horizontal) {
                LazyHGrid(rows: layout) {
                    ForEach(0..<1000) {
                        Text("Item \($0)")
                    }
                }
            }
        }
    }
}

struct GridViews_Previews: PreviewProvider {
    static var previews: some View {
        GridViews()
        GridViews()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
