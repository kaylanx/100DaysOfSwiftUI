//
//  CustomAlignmentGuides.swift
//  LayoutAndGeometry
//
//  Created by Andy Kayley on 29/09/2022.
//

import SwiftUI

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct CustomAlignmentGuides: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@darthmoonmonkey")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }

                Image("Example")
                    .resizable()
                    .frame(width: 64, height: 64)
            }

            VStack {
                Text("Full name:")
                Text("ANDY KAYLEY")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
        }
    }
}

struct CustomAlignmentGuides_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlignmentGuides()
    }
}
