//
//  ScrollViewWithGeometryReader.swift
//  LayoutAndGeometry
//
//  Created by Andy Kayley on 04/10/2022.
//

import SwiftUI

struct ScrollViewWithGeometryReader: View {

    private let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(0..<20) { index in
                    GeometryReader { geo in
                        Text("Number \(index)")
                            .font(.largeTitle)
                            .padding()
                            .background(colors[index % colors.count])
                            .rotation3DEffect(
                                .degrees(-geo.frame(in: .global).minX) / 8,
                                axis: (x: 0, y: 1, z: 0)
                            )
                            .frame(width: 200, height: 200)
                    }
                    .frame(width: 200, height: 200)

                }
            }
        }
    }
}

struct ScrollViewWithGeometryReader_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewWithGeometryReader()
    }
}

struct BasicScrollViewWithGeometryReader: View {

    private let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .frame(height: max(50, abs(geo.size.height - geo.frame(in: .global).minY / 3.5)))
                            .background(
                                Color(
                                    hue: min(1, (geo.frame(in: .global).minY * 0.0008)),
                                    saturation: 1,
                                    brightness: 1
                                )
                            )
                            .rotation3DEffect(
                                .degrees(
                                    geo.frame(in: .global).minY - fullView.size.height / 2
                                ) / 5,
                                axis: (x: 0, y: 1, z: 0)
                            )
                            .opacity(geo.frame(in: .global).minY / 200)
                    }
                    .frame(height: 50)
                }
            }
        }
    }
}

struct BasicScrollViewWithGeometryReader_Previews: PreviewProvider {
    static var previews: some View {
        BasicScrollViewWithGeometryReader()
    }
}
