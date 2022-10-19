//
//  BoxView.swift
//  Dice
//
//  Created by Andy Kayley on 19/10/2022.
//
//  Helped by https://betterprogramming.pub/how-to-draw-in-3d-with-swiftui-7989cfcd35fc 
//
//

import SwiftUI

struct BoxView: View {

    @State private var blueDegree: Double = 180
    @State private var blueOffset: CGFloat = -90
    @State private var bluePerspective: CGFloat = -0.1
    @State private var blueZIndex: Double = 0

    @State private var redDegree: Double = 90
    @State private var redOffset: CGFloat = 0
    @State private var redPerspective: CGFloat = -0.1
    @State private var redZIndex: Double = 0

    @State private var greenDegree: Double = 90
    @State private var greenOffset: CGFloat = 90
    @State private var greenPerspective: CGFloat = 0.1
    @State private var greenZIndex: Double = 0

    @State private var orangeDegree: Double = 0
    @State private var orangeOffset: CGFloat = 0
    @State private var orangePerspective: CGFloat = 0.1
    @State private var orangeZIndex: Double = 1



    var body: some View {
        VStack {
            Button("Run 1") {
                withAnimation(.linear(duration: 1)) {
                    blueDegree = 270
                    blueOffset = 0

                    redDegree = 180
                    redOffset = 90

                    greenDegree = 0
                    greenOffset = 0

                    orangeDegree = 90
                    orangeOffset = -90
                }
            }
            Button("Run 2") {

                orangeZIndex = 0
                blueZIndex = 1

                bluePerspective = 0.1
                redPerspective = -0.1
                greenPerspective = -0.1
                orangePerspective = 0.1

                withAnimation(.linear(duration: 1)) {
                    blueDegree = 360
                    blueOffset = 0

                    redDegree = 270
                    redOffset = 90

                    greenDegree = 90
                    greenOffset = 0

                    orangeDegree = 180
                    orangeOffset = -90
                }
            }
            Button("Reset") {

                bluePerspective = -0.1
                redPerspective = -0.1
                greenPerspective = 0.1
                orangePerspective = 0.1

                withAnimation(.linear(duration: 1)) {
                    blueDegree = 180
                    blueOffset = -90

                    redDegree = 90
                    redOffset = 0

                    greenDegree = 90
                    greenOffset = 90

                    orangeDegree = 0
                    orangeOffset = 0
                }
            }
            Spacer()
            ZStack {

                Spacer()
                side(
                    text: "blue",
                    color: .blue,
                    textOffsetWidth: 24,
                    degrees: blueDegree,
                    offset: blueOffset,
                    yAxis: -1,
                    anchor: .trailing,
                    perspective: bluePerspective,
                    zIndex: blueZIndex
                )

                side(
                    text: "red",
                    color: .red,
                    textOffsetWidth: -24,
                    degrees: redDegree,
                    offset: redOffset,
                    yAxis: -1,
                    anchor: .leading,
                    perspective: redPerspective,
                    zIndex: redZIndex
                )
                Spacer()
                Spacer()
                side(
                    text: "green",
                    color: .green,
                    textOffsetHeight: 24,
                    degrees: greenDegree,
                    offset: greenOffset,
                    yAxis: 1,
                    anchor: .leading,
                    perspective: greenPerspective,
                    zIndex: greenZIndex
                )

                side(
                    text: "orange",
                    color: .orange,
                    textOffsetHeight: -24,
                    degrees: orangeDegree,
                    offset: orangeOffset,
                    yAxis: -1,
                    anchor: .trailing,
                    perspective: orangePerspective,
                    zIndex: orangeZIndex
                )
                Spacer()
            }
        }

    }

    private func side(
        text: String,
        color: Color,
        textOffsetWidth: Int = 0,
        textOffsetHeight: Int = 0,
        degrees: Double,
        offset: CGFloat,
        yAxis: CGFloat,
        anchor: UnitPoint,
        perspective: CGFloat,
        zIndex: Double
    ) -> some View {
        ZStack {
            Text(text)
                .offset(.init(width: textOffsetWidth, height: textOffsetHeight))
            Rectangle()
                .stroke(color, lineWidth: 5)
                .opacity(0.9)
                .frame(width: 90, height: 90, alignment: .center)
        }
        .rotation3DEffect(
            .degrees(degrees),
            axis: (x: 0, y: yAxis, z: 0),
            anchor: anchor,
            perspective: perspective
        )
        .offset(CGSize(width: offset, height: 0))
        .zIndex(zIndex)
    }
}


struct BoxView_Previews: PreviewProvider {
    static var previews: some View {
        BoxView()
    }
}
