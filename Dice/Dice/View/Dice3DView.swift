//
//  BoxView.swift
//  Dice
//
//  Created by Andy Kayley on 12/10/2022.
//

import SwiftUI

class RotationData: ObservableObject {
    @Published var rotationDegree: Double
    @Published var rotationOffset: CGFloat
    @Published var yAxis: CGFloat
    @Published var perspective: CGFloat

    init(degree: Double, offset: CGFloat, yAxis: CGFloat, perspective: CGFloat) {
        self.rotationDegree = degree
        self.rotationOffset = offset
        self.yAxis = yAxis
        self.perspective = perspective
    }

    func addToRotationData(degree: Double, offset: CGFloat) {
        rotationDegree += degree
        rotationOffset += offset
    }
}

struct Dice3DView: View {

    @StateObject
    var rearFaceRotationData = RotationData(
        degree: 180,
        offset: -90,
        yAxis: 1.0,
        perspective: 0.1
    )

    @StateObject
    var leftFaceRotationData = RotationData(
        degree: 90,
        offset: 0,
        yAxis: 1.0,
        perspective: 0.1
    )

    @StateObject
    var rightFaceRotationData = RotationData(
        degree: 90,
        offset: 90,
        yAxis: 1.0,
        perspective: 0.1
    )

    @StateObject
    var frontFaceRotationData = RotationData(
        degree: 0,
        offset: 0,
        yAxis: -1.0,
        perspective: 0.1
    )


    var body: some View {
        VStack {
            Text("Run")
                .onTapGesture {
                    withAnimation {

                        /*
                         Rear side
                         degrees: 180 -> 270
                         offset: -90 -> 0
                         yAxis: 1.0 -> 1.0 (rear to right)
                         perspective: -0.1 -> 0.1 (rear to right)

                         Front side
                         degrees: 0 -> 90
                         offset: 0 -> -90
                         yAxis: -1.0 -> 1.0 (front to left)
                         perspective: 0.1 -> -0.1 (front to left)

                         Left side
                         degree: 90 -> 180
                         offset: 0 -> 90
                         yAxis: 1.0 -> 1.0 (Left to rear)
                         perspective: -0.1 -> -0.1 (Left to rear)

                         Right side
                         degree: 90 -> 0,
                         offset: 90 -> 0,
                         yAxis: 1.0 -> -1.0, (Right to front)
                         perspective: 0.1 -> 0.1 (Right to front)

                         */
                        rearFaceRotationData.addToRotationData(degree: 90, offset: 90)
                        leftFaceRotationData.addToRotationData(degree: 90, offset: 90)
                        rightFaceRotationData.addToRotationData(degree: -90, offset: -90)
                        frontFaceRotationData.addToRotationData(degree: 90, offset: -90)
                    }
                }
            ZStack {
                DiceView(dice: SixSidedDice.six)
                    .frame(width: 90, height: 90, alignment: .center)
                    .rotation3DEffect(
                        .degrees(rearFaceRotationData.rotationDegree),
                        axis: (x: 0, y: rearFaceRotationData.yAxis, z: 0),
                        anchor: .trailing,
                        perspective: rearFaceRotationData.perspective
                    )
                    .offset(.init(width: rearFaceRotationData.rotationOffset, height: 0))

                DiceView(dice: SixSidedDice.two)
                    .frame(width: 90, height: 90, alignment: .center)
                    .rotation3DEffect(
                        .degrees(leftFaceRotationData.rotationDegree),
                        axis: (x: 0, y: leftFaceRotationData.yAxis, z: 0),
                        anchor: .leading,
                        perspective: leftFaceRotationData.perspective
                    )
                    .offset(.init(width: leftFaceRotationData.rotationOffset, height: 0))

                DiceView(dice: SixSidedDice.five)
                    .frame(width: 90, height: 90, alignment: .center)
                    .rotation3DEffect(
                        .degrees(rightFaceRotationData.rotationDegree),
                        axis: (x: 0, y: rightFaceRotationData.yAxis, z: 0),
                        anchor: .leading,
                        perspective: rightFaceRotationData.perspective
                    )
                    .offset(.init(width: rightFaceRotationData.rotationOffset, height: 0))

                DiceView(dice: SixSidedDice.one)
                    .frame(width: 90, height: 90, alignment: .center)
                    .rotation3DEffect(
                        .degrees(frontFaceRotationData.rotationDegree),
                        axis: (x: 0, y: frontFaceRotationData.yAxis, z: 0),
                        anchor: .trailing,
                        perspective: frontFaceRotationData.perspective
                    )
                    .offset(x: frontFaceRotationData.rotationOffset, y: 0)

            }
            Text("Reset")
                .onTapGesture {
                    withAnimation {
                        rearFaceRotationData.rotationDegree = 180
                        rearFaceRotationData.rotationOffset = -90

                        leftFaceRotationData.rotationDegree = 90
                        leftFaceRotationData.rotationOffset = 0

                        rightFaceRotationData.rotationDegree = 90
                        rightFaceRotationData.rotationOffset = 90

                        frontFaceRotationData.rotationDegree = 0
                        frontFaceRotationData.rotationOffset = 0
                    }
                }
        }

    }
}

struct Dice3DView_Previews: PreviewProvider {
    static var previews: some View {
        Dice3DView()
    }
}
