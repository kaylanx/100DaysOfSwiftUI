//
//  ConditionalDividerList.swift
//  FriendFace
//
//  Created by Andy Kayley on 12/07/2022.
//

import SwiftUI

struct ConditionalDividerList: View {

    let items: [String]

    var body: some View {
        ForEach(items, id: \.self) { item in
            Text(item)
                .padding(.bottom, items.last == item ? 10 : 0)
            if items.last != item {
                Divider()
            }
        }
    }
}

struct ConditionalDividerList_Previews: PreviewProvider {
    static var previews: some View {
        SectionCell(title: "Heading") {
            ConditionalDividerList(
                items: ["One", "Two", "Three", "Four"]
            )
        }
    }
}
