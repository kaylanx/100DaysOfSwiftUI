//
//  Alignments.swift
//  LayoutAndGeometry
//
//  Created by Andy Kayley on 29/09/2022.
//

import SwiftUI

struct Alignments: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Hello, world!")
                    .background(Color.red)
                    .padding()

                Text("Hello, world!")
                    .padding()
                    .background(Color.red)

                Text("Live long and prosper")
                    .frame(width: 300, height: 300, alignment: .topLeading)
                    .background(.cyan)

                Text("Live long and prosper")
                    .frame(width: 300, height: 300)
                    .background(.cyan)

                HStack {
                    Text("Live")
                        .font(.caption)
                    Text("long")
                    Text("and")
                        .font(.title)
                    Text("prosper")
                        .font(.largeTitle)
                }

                Divider()

                HStack(alignment: .bottom) {
                    Text("Live")
                        .font(.caption)
                    Text("long")
                    Text("and")
                        .font(.title)
                    Text("prosper")
                        .font(.largeTitle)
                }

                Divider()

                HStack(alignment: .lastTextBaseline) {
                    Text("Live")
                        .font(.caption)
                    Text("long")
                    Text("and")
                        .font(.title)
                    Text("prosper")
                        .font(.largeTitle)
                }

                Divider()

            }
            .padding()
        }
    }
}

struct Alignments_Previews: PreviewProvider {
    static var previews: some View {
        Alignments()
    }
}
