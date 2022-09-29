//
//  AlignmentGuides.swift
//  LayoutAndGeometry
//
//  Created by Andy Kayley on 29/09/2022.
//

import SwiftUI

struct AlignmentGuides: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Hello, world!")
                Text("This is a longer line of text")
            }
            .background(.red)
            .frame(width: 400, height: 400)
            .background(.blue)

            VStack(alignment: .leading) {
                Text("Hello, world!")
                    .alignmentGuide(.leading) { viewDimensions in
                        viewDimensions[.leading]
                    }
                Text("This is a longer line of text")
            }

            VStack(alignment: .leading) {
                Text("Hello, world!")
                    .alignmentGuide(.leading) { viewDimensions in
                        viewDimensions[.trailing]
                    }
                    .background(.cyan)
                Text("This is a longer line of text")
                    .background(.cyan)
            }
            .background(.red)
            .frame(width: 400, height: 400)
            .background(.blue)

            VStack(alignment: .leading) {
                ForEach(0..<10) { position in
                    Text("Number \(position)")
                        .alignmentGuide(.leading) { _ in CGFloat(position) * -10 }
                }
            }
            .background(.red)
            .frame(width: 400, height: 400)
            .background(.blue)
        }
    }
}

struct AlignmentGuides_Previews: PreviewProvider {
    static var previews: some View {
        AlignmentGuides()
    }
}
