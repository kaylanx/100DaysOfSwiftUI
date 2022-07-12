//
//  SectionCell.swift
//  FriendFace
//
//  Created by Andy Kayley on 12/07/2022.
//

import SwiftUI

struct SectionCell<Content: View>: View {

    let title: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondaryLabel)
            content
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}


struct SectionCell_Previews: PreviewProvider {
    static var previews: some View {
        SectionCell(title: "Title") {
            Text("Content")
        }
    }
}
