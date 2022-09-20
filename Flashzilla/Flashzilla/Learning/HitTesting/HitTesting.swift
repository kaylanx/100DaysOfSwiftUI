//
//  HitTesting.swift
//  Flashzilla
//
//  Created by Andy Kayley on 20/09/2022.
//

import SwiftUI

enum HitTesting {

    struct SpacersDontGetTaps: View {
        var body: some View {
            VStack {
                Text("Hello")
                Spacer().frame(height: 100)
                Text("World")
            }
            .onTapGesture {
                print("VStack tapped!")
            }
        }
    }

    struct SpacersGetsTaps: View {
        var body: some View {
            VStack {
                Text("Hello")
                Spacer().frame(height: 100)
                Text("World")
            }
            .contentShape(Rectangle())
            .onTapGesture {
                print("VStack tapped!")
            }
        }
    }

    struct AllowsHitTestingContentView: View {
        var body: some View {
            ZStack {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 300, height: 300)
                    .onTapGesture {
                        print("Rectangle tapped!")
                    }

                Circle()
                    .fill(.red)
                    .frame(width: 300, height: 300)
                    .onTapGesture {
                        print("Red circle tapped!")
                    }
                    .allowsHitTesting(false)

                Circle()
                    .fill(.green)
                    .frame(width: 200, height: 200)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        print("Green circle tapped!")
                    }
            }
        }
    }

    struct HitTesting_Previews: PreviewProvider {
        static var previews: some View {
            AllowsHitTestingContentView()
            SpacersDontGetTaps()
            SpacersGetsTaps()
        }
    }
}
