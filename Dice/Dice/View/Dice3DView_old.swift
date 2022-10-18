//
//  BoxView.swift
//  Dice
//
//  Created by Andy Kayley on 12/10/2022.
//

import SwiftUI
struct OLD {
    enum Side {
        case rear
        case left
        case right
        case front

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

        var addDegreesToRotateLeft: Double {
            switch self {
                case .rear: return 90
                case .left: return 90
                case .right: return -90
                case .front: return 90
            }
        }

        var addOffsetToRotateLeft: Double {
            switch self {
                case .rear: return 90
                case .left: return 90
                case .right: return -90
                case .front: return -90
            }
        }

        var afterRotatedLeft: Side {
            switch self {
                case .rear: return .right
                case .left: return .rear
                case .right: return .front
                case .front: return .left
            }
        }

        var rotateRight: Side {
            switch self {
                case .rear: return .left
                case .left: return .front
                case .right: return .rear
                case .front: return .right
            }
        }

        var degree: Double {
            switch self {
                case .rear: return 180
                case .left: return 90
                case .right: return 90
                case .front: return 0
            }
        }

        var offset: CGFloat {
            switch self {
                case .rear: return -90
                case .left: return 0
                case .right: return 90
                case .front: return 0
            }
        }

        var yAxis: CGFloat {
            switch self {
                case .rear: return 1.0
                case .left: return 1.0
                case .right: return 1.0
                case .front: return 1.0
            }
        }

        var perspective: CGFloat {
            switch self {
                case .rear: return -0.1
                case .left: return -0.1
                case .right: return 0.1
                case .front: return 0.1
            }
        }

        var anchor: UnitPoint {
            switch self {
                case .rear: return .trailing
                case .left: return .leading
                case .right: return .leading
                case .front: return .trailing
            }
        }
    }

    class RotationData: ObservableObject {
        @Published var rotationDegree: Double
        @Published var rotationOffset: CGFloat

        private(set) var yAxis: CGFloat
        private(set) var perspective: CGFloat
        private(set) var anchor: UnitPoint

        private(set) var side: Side

        init(side: Side) {
            self.side = side
            self.rotationDegree = side.degree
            self.rotationOffset = side.offset
            self.yAxis = side.yAxis
            self.perspective = side.perspective
            self.anchor = side.anchor
        }
        //
        //    func addToRotationData(degree: Double, offset: CGFloat) {
        //        rotationDegree += degree
        //        rotationOffset += offset
        //    }

        func rotateLeft() {
            rotationDegree += side.addOffsetToRotateLeft
            rotationOffset += side.addOffsetToRotateLeft

            //        yAxis = side.afterRotatedLeft.yAxis
            //        perspective = side.afterRotatedLeft.perspective
            //        anchor = side.afterRotatedLeft.anchor
        }

        func rotateRight() {
            let rotatedSide = side.rotateRight
            rotationDegree = rotatedSide.degree
            rotationOffset = rotatedSide.offset
        }

        func set(side: Side) {
            rotationDegree = side.degree
            rotationOffset = side.offset
            yAxis = side.yAxis
            perspective = side.perspective
            anchor = side.anchor
        }

        func printRotationData() {
            print(
            """
            =================\(side)=================
            | rotationDegree = \(rotationDegree)
            | rotationOffset = \(rotationOffset)
            | yAxis          = \(yAxis)
            | perspective    = \(perspective)
            | anchor         = \(anchor)
            =========================================
            """
            )
        }
    }

    struct Dice3DView: View {

        //    @ObservedObject
        var sixFaceRotationData = RotationData(side: .rear)

        //    @ObservedObject
        var twoFaceRotationData = RotationData(side: .left)

        //    @ObservedObject
        var fiveFaceRotationData = RotationData(side: .right)

        //    @ObservedObject
        var oneFaceRotationData = RotationData(side: .front)

        var body: some View {
            VStack {
                Text("Run")
                    .onTapGesture {
                        withAnimation() {


                            //                        sixFaceRotationData.addToRotationData(degree: 90, offset: 90)

                            //                        sixFaceRotationData.set(side: .rear.afterRotatedLeft)
                            //                        twoFaceRotationData.set(side: .left.afterRotatedLeft)
                            //                        fiveFaceRotationData.set(side: .right.afterRotatedLeft)
                            //                        oneFaceRotationData.set(side: .front.afterRotatedLeft)




                            sixFaceRotationData.printRotationData()
                            sixFaceRotationData.rotateLeft()
                            sixFaceRotationData.printRotationData()


                            //                        twoFaceRotationData.addToRotationData(degree: 90, offset: 90)
                            twoFaceRotationData.printRotationData()
                            twoFaceRotationData.rotateLeft()
                            twoFaceRotationData.printRotationData()


                            //                        fiveFaceRotationData.addToRotationData(degree: -90, offset: -90)
                            fiveFaceRotationData.printRotationData()
                            fiveFaceRotationData.rotateLeft()
                            fiveFaceRotationData.printRotationData()

                            //                        oneFaceRotationData.addToRotationData(degree: 90, offset: -90)
                            oneFaceRotationData.printRotationData()
                            oneFaceRotationData.rotateLeft()
                            oneFaceRotationData.printRotationData()

                        }

                        //                    sixFaceRotationData.didRotateLeft()
                        //                    twoFaceRotationData.didRotateLeft()
                        //                    fiveFaceRotationData.didRotateLeft()
                        //                    oneFaceRotationData.didRotateLeft()
                        //                    sixFaceRotationData.set(side: sixFaceRotationData.side.afterRotatedLeft)
                        //                    twoFaceRotationData.set(side: twoFaceRotationData.side.afterRotatedLeft)
                        //                    fiveFaceRotationData.set(side: fiveFaceRotationData.side.afterRotatedLeft)
                        //                    oneFaceRotationData.set(side: oneFaceRotationData.side.afterRotatedLeft)
                    }
                ZStack {
                    //                DiceView(dice: SixSidedDice.six)
                    //                    .modifier(DiceRotationViewModifier(rotationData: sixFaceRotationData))
                    //
                    //                DiceView(dice: SixSidedDice.two)
                    //                    .modifier(DiceRotationViewModifier(rotationData: twoFaceRotationData))
                    //
                    //                DiceView(dice: SixSidedDice.five)
                    //                    .modifier(DiceRotationViewModifier(rotationData: fiveFaceRotationData))


                    DiceView(dice: SixSidedDice.one)
                        .modifier(DiceRotationViewModifier(rotationData: oneFaceRotationData))
                }
                Text("Reset")
                    .onTapGesture {
                        withAnimation {
                            sixFaceRotationData.printRotationData()
                            sixFaceRotationData.set(side: .rear)
                            print("<======>")
                            sixFaceRotationData.printRotationData()

                            twoFaceRotationData.set(side: .left)
                            fiveFaceRotationData.set(side: .right)
                            oneFaceRotationData.set(side: .front)
                        }
                    }
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

}
