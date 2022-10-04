//
//  AbsolutePositioning.swift
//  LayoutAndGeometry
//
//  Created by Andy Kayley on 04/10/2022.
//

import SwiftUI

struct AbsolutePositioning: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Text("Hello, World!")
                .offset(x: 100, y: 50)
                .background(.red)


            Text("Hello, World!")
                .background(.red)
                .position(x: 100, y: 50)
        }
    }
}

struct AbsolutePositioning_Previews: PreviewProvider {
    static var previews: some View {
        AbsolutePositioning()
    }
}
