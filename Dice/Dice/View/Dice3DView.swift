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
    var zIndex: Double { get }
    @discardableResult func next() -> Side
    @discardableResult func previous() -> Side
}

extension Side {
    var yAxis: CGFloat {
        -1.0
    }

    var perspective: CGFloat {
        0.1
    }

    var anchor: UnitPoint {
        .trailing
    }
}

enum FaceSide: CaseIterable {
    case front, left, right, back

    var zIndex: Double {
        switch self {
            case .front: return 1
            default: return 0
        }
    }

    func rotateLeft() -> FaceSide {
        switch self {
            case .front: return .left
            case .left: return .back
            case .right: return .front
            case .back: return .right
        }
    }

    func rotateRight() -> FaceSide {
        switch self {
            case .front: return .right
            case .left: return .front
            case .right: return .back
            case .back: return .left
        }
    }
}

class DiceSide: Side {
    var rotationDegree: Double
    var zIndex: Double {
        faceSide.zIndex
    }

    private var faceSide: FaceSide

    init(initialRotationDegree degree: Double, faceSide: FaceSide) {
        self.rotationDegree = degree
        self.faceSide = faceSide
    }

    var rotationOffset: CGFloat {
        offsets[index]
    }

    private var index = 0
    private let offsets: [CGFloat] = [
        0,
        -90,
        -90,
        0
    ]

    func next() -> Side {
        if index + 1 == offsets.count {
            index = 0
        } else {
            index += 1
        }
        rotationDegree += 90
        faceSide = faceSide.rotateLeft()
        return self
    }

    func previous() -> Side {
        if index - 1 < 0 {
            index = offsets.count - 1
        } else {
            index -= 1
        }
        rotationDegree -= 90
        faceSide = faceSide.rotateRight()
        return self
    }
}

class RotationData: ObservableObject {
    @Published var rotationDegree: Double
    @Published var rotationOffset: CGFloat

    @Published var yAxis: CGFloat
    @Published var perspective: CGFloat
    @Published var anchor: UnitPoint

    @Published var side: Side

    @Published var zIndex: Double

    init(side: Side) {
        self.side = side
        self.rotationDegree = side.rotationDegree
        self.rotationOffset = side.rotationOffset
        self.yAxis = side.yAxis
        self.perspective = side.perspective
        self.anchor = side.anchor
        self.zIndex = side.zIndex
    }

    func rotateLeft() {
        set(side: side.next())
    }

    func rotateRight() {
        set(side: side.previous())
    }

    func set(side: Side) {
        rotationDegree = side.rotationDegree
        rotationOffset = side.rotationOffset
        yAxis = side.yAxis
        perspective = side.perspective
        anchor = side.anchor
        zIndex = side.zIndex
        self.side = side
    }
}

struct Dice3DView: View {

    @ObservedObject
    var oneFaceRotationData = RotationData(side: DiceSide(initialRotationDegree: 0, faceSide: .front))

    @ObservedObject
    var twoFaceRotationData = RotationData(side: DiceSide(initialRotationDegree: 90, faceSide: .right).next().next())

    @ObservedObject
    var fiveFaceRotationData = RotationData(side: DiceSide(initialRotationDegree: 90, faceSide: .right))

    @ObservedObject
    var sixFaceRotationData = RotationData(side: DiceSide(initialRotationDegree: 0, faceSide: .front).next().next())


    var body: some View {
        VStack {

            Form {
                Section("One") {
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

                Section("two") {
                    HStack {
                        Text("Degree: ")
                            .font(.title2)
                        TextField("Degree", value: $twoFaceRotationData.rotationDegree, format: .number)
                    }
                    Stepper("Offset \(twoFaceRotationData.rotationOffset)", value: $twoFaceRotationData.rotationOffset)
                    Stepper("Y Axis \(twoFaceRotationData.yAxis)", value: $twoFaceRotationData.yAxis)
                    Stepper("Perspective \(twoFaceRotationData.perspective)", value: $twoFaceRotationData.perspective)
                    HStack {
                        Text("Anchor: ")
                            .font(.title2)
                        Text("\(twoFaceRotationData.anchor == .leading ? "Leading" : "Trailing")")
                    }
                }

                Section("Five") {
                    HStack {
                        Text("Degree: ")
                            .font(.title2)
                        TextField("Degree", value: $fiveFaceRotationData.rotationDegree, format: .number)
                    }

                    Stepper("Offset \(fiveFaceRotationData.rotationOffset)", value: $fiveFaceRotationData.rotationOffset)
                    Stepper("Y Axis \(fiveFaceRotationData.yAxis)", value: $fiveFaceRotationData.yAxis)
                    Stepper("Perspective \(fiveFaceRotationData.perspective)", value: $fiveFaceRotationData.perspective)
                    HStack {
                        Text("Anchor: ")
                            .font(.title2)
                        Text("\(fiveFaceRotationData.anchor == .leading ? "Leading" : "Trailing")")
                    }
                }

                Section("Six") {
                    HStack {
                        Text("Degree: ")
                            .font(.title2)
                        TextField("Degree", value: $sixFaceRotationData.rotationDegree, format: .number)
                    }

                    Stepper("Offset \(sixFaceRotationData.rotationOffset)", value: $sixFaceRotationData.rotationOffset)
                    Stepper("Y Axis \(sixFaceRotationData.yAxis)", value: $sixFaceRotationData.yAxis)
                    Stepper("Perspective \(sixFaceRotationData.perspective)", value: $sixFaceRotationData.perspective)
                    HStack {
                        Text("Anchor: ")
                            .font(.title2)
                        Text("\(sixFaceRotationData.anchor == .leading ? "Leading" : "Trailing")")
                    }
                }
            }

            ZStack {

                DiceView(dice: SixSidedDice.six)
                    .modifier(DiceRotationViewModifier(rotationData: sixFaceRotationData))

                DiceView(dice: SixSidedDice.two)
                    .modifier(DiceRotationViewModifier(rotationData: twoFaceRotationData))

                DiceView(dice: SixSidedDice.five)
                    .modifier(DiceRotationViewModifier(rotationData: fiveFaceRotationData))

                DiceView(dice: SixSidedDice.one)
                    .modifier(DiceRotationViewModifier(rotationData: oneFaceRotationData))
            }

            HStack {
                Button("Rotate Left") {
                    withAnimation() {
                        oneFaceRotationData.rotateLeft()
                        twoFaceRotationData.rotateLeft()
                        fiveFaceRotationData.rotateLeft()
                        sixFaceRotationData.rotateLeft()
                    }
                }
                .padding()
                .background(Color.dicePrimary)
                .foregroundColor(.diceSecondary)
                .clipShape(Capsule())

                Button("Rotate Right") {
                    withAnimation {
                        oneFaceRotationData.rotateRight()
                        twoFaceRotationData.rotateRight()
                        fiveFaceRotationData.rotateRight()
                        sixFaceRotationData.rotateRight()
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
            .zIndex(rotationData.zIndex)
    }
}

struct Dice3DView_Previews: PreviewProvider {
    static var previews: some View {
        Dice3DView()
    }
}
