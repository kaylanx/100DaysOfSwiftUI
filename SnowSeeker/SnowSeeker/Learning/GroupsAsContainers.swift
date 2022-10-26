//
//  GroupsAsContainers.swift
//  SnowSeeker
//
//  Created by Andy Kayley on 26/10/2022.
//

import SwiftUI

enum GroupsAsContainers {

    struct UserView: View {
        var body: some View {
            Group {
                Text("Name: Paul")
                Text("Country: England")
                Text("Pets: Luna and Arya")
            }
            .font(.title)
        }
    }

    struct ContentView1: View {
        @State private var layoutVertically = false

        var body: some View {
            Group {
                if layoutVertically {
                    VStack {
                        UserView()
                    }
                } else {
                    HStack {
                        UserView()
                    }
                }
            }
            .onTapGesture {
                layoutVertically.toggle()
            }
        }
    }

    struct ContentView2: View {
        @Environment(\.horizontalSizeClass) var sizeClass

        var body: some View {
            if sizeClass == .compact {
                VStack {
                    UserView()
                }
            } else {
                HStack {
                    UserView()
                }
            }
        }
    }

    struct ContentView3: View {
        @Environment(\.horizontalSizeClass) var sizeClass

        var body: some View {
            if sizeClass == .compact {
                VStack(content: UserView.init)
            } else {
                HStack(content: UserView.init)
            }
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView1()
            ContentView2()
            ContentView3()
        }
    }
}
