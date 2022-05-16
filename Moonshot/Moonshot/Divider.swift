//
//  Divider.swift
//  Moonshot
//
//  Created by Andy Kayley on 16/05/2022.
//

import SwiftUI

struct Divider: View {
    var body: some View {
        Rectangle()
            .frame(height:2)
            .foregroundColor(.lightBackground)
        .padding(.vertical)
    }
}

struct Divider_Previews: PreviewProvider {
    static var previews: some View {
        Divider()
            .preferredColorScheme(.dark)
    }
}
