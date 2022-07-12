//
//  SectionView.swift
//  FriendFace
//
//  Created by Andy Kayley on 12/07/2022.
//

import SwiftUI

struct SectionView<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        ZStack(alignment: .leading) {
            Color.secondarySystemGroupedBackground
            VStack(alignment: .leading) {
                content
            }
        }
        .cornerRadius(4)
        .padding(5)
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        LazyVStack {
            SectionView {
                Text("Hello world")
                Text("Something else")
            }
        }
        .padding()
    }
}
