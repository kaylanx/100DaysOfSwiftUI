//
//  Dice3DView.swift
//  Dice
//
//  Created by Andy Kayley on 18/10/2022.
//

import SwiftUI

    /*
     Rear side
     degrees: 180 -> 270   + 90
     offset: -90 -> 0      + 90
     yAxis: 1.0 -> 1.0 (rear to right)
     perspective: -0.1 -> 0.1 (rear to right)

     Left side
     degree: 90 -> 180     + 90
     offset: 0 -> 90       + 90
     yAxis: 1.0 -> 1.0 (Left to rear)
     perspective: -0.1 -> -0.1 (Left to rear)

     Right side
     degree: 90 -> 0,      + -90
     offset: 90 -> 0,      + -90
     yAxis: 1.0 -> -1.0, (Right to front)
     perspective: 0.1 -> 0.1 (Right to front)

     Front side
     degrees: 0 -> 90      + 90
     offset: 0 -> -90      + -90
     yAxis: -1.0 -> 1.0 (front to left)
     perspective: 0.1 -> -0.1 (front to left)
     */


protocol Side {
    var rotationDegree: Double { get }
    var rotationOffset: CGFloat { get }
    var yAxis: CGFloat { get }
    var perspective: CGFloat { get }
    var anchor: UnitPoint { get }
    func next()
}

class FrontSide: Side {
    var rotationDegree: Double = 0
    var rotationOffset: CGFloat {
        offsets[index]
    }

    var yAxis: CGFloat {
        -1.0
    }

    var perspective: CGFloat {
        0.1
    }

    var anchor: UnitPoint {
        .trailing
    }

    private var index = 0
    private let offsets: [CGFloat] = [
        0,
        -90,
        -90,
        0
    ]

    func next() {
        if index + 1 == offsets.count {
            index = 0
        } else {
            index += 1
        }
        rotationDegree += 90
    }
}

class RotationData: ObservableObject {
    @Published var rotationDegree: Double
    @Published var rotationOffset: CGFloat

    @Published  var yAxis: CGFloat
    @Published  var perspective: CGFloat
    @Published  var anchor: UnitPoint

    @Published  var side: Side

    init(side: Side) {
        self.side = side
        self.rotationDegree = side.rotationDegree
        self.rotationOffset = side.rotationOffset
        self.yAxis = side.yAxis
        self.perspective = side.perspective
        self.anchor = side.anchor
    }

    func rotateLeft() {
        side.next()
        set(side: side)
    }

    func set(side: Side) {
        rotationDegree = side.rotationDegree
        rotationOffset = side.rotationOffset
        yAxis = side.yAxis
        perspective = side.perspective
        anchor = side.anchor
        self.side = side
    }
}

struct Dice3DView: View {

    @ObservedObject
    var oneFaceRotationData = RotationData(side: FrontSide())

    var body: some View {
        VStack {

            Form {
                HStack {
                    Text("Degree: ")
                        .font(.title2)
                    TextField("Degree", value: $oneFaceRotationData.rotationDegree, format: .number)
                }

                Stepper("Offset \(oneFaceRotationData.rotationOffset)", value: $oneFaceRotationData.rotationOffset)
                Stepper("Y Axis \(oneFaceRotationData.yAxis)", value: $oneFaceRotationData.yAxis)
                Stepper("Perspective \(oneFaceRotationData.perspective)", value: $oneFaceRotationData.perspective)
                HStack {
                    Text("Anchor: ")
                        .font(.title2)
                    Text("\(oneFaceRotationData.anchor == .leading ? "Leading" : "Trailing")")
                }
            }

            ZStack {
                DiceView(dice: SixSidedDice.one)
                    .modifier(DiceRotationViewModifier(rotationData: oneFaceRotationData))
            }

            HStack {
                Button("Rotate Left") {
                    withAnimation() {
                        oneFaceRotationData.rotateLeft()
                    }
                }
                .padding()
                .background(Color.dicePrimary)
                .foregroundColor(.diceSecondary)
                .clipShape(Capsule())

                Button("Reset") {
                    withAnimation {
                        oneFaceRotationData.set(side: FrontSide())
                    }
                }
                .padding()
                .background(Color.dicePrimary)
                .foregroundColor(.diceSecondary)
                .clipShape(Capsule())
            }
            .padding(.top, 20)
        }
    }

}

struct DiceRotationViewModifier: ViewModifier {

    @StateObject var rotationData: RotationData

    func body(content: Content) -> some View {
        content
            .frame(width: 90, height: 90, alignment: .center)
            .rotation3DEffect(
                .degrees(rotationData.rotationDegree),
                axis: (x: 0, y: rotationData.yAxis, z: 0),
                anchor: rotationData.anchor,
                perspective: rotationData.perspective
            )
            .offset(.init(width: rotationData.rotationOffset, height: 0))
    }
}

struct Dice3DView_Previews: PreviewProvider {
    static var previews: some View {
        Dice3DView()
    }
}
