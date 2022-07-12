//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Andy Kayley on 08/07/2022.
//

import SwiftUI

struct UserDetailView: View {

    var user: User

    var body: some View {
        ZStack {
            Color.systemGroupedBackground
            ScrollView {
                LazyVStack {

                    initialsCircle

                    Text(user.name)
                        .font(.largeTitle)
                    Text(user.company)
                        .font(.body)
                        .foregroundColor(.secondaryLabel)


                    SectionView {
                        SectionCell(title: "Member since") {
                            Text("\(user.formattedRegistered)")
                        }
                    }
                    SectionView {
                        SectionCell(title: "Age") {
                            Text("\(user.age)")
                        }
                    }
                    SectionView {
                        SectionCell(title: "Email") {
                            Text(user.email)
                        }
                        Divider()
                            .padding(.leading)
                        SectionCell(title: "Address") {
                            Text(user.address)
                        }
                    }
                    SectionView {
                        SectionCell(title: "About") {
                            Text(user.about)
                        }
                    }
                    SectionView {
                        SectionCell(title:"Tags") {
                            ConditionalDividerList(
                                items: user.tags
                            )
                        }
                    }
                    SectionView {
                        SectionCell(title: "Friends") {
                            ConditionalDividerList(
                                items: user.friends.map { $0.name }
                            )
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.systemGroupedBackground)
    }


    func useProxy(_ geometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.circleDiameter = geometry.frame(in: .global).minY > 0.0 ? geometry.frame(in: .global).minY : 0
        }

        return EmptyView()
    }

    @State private var circleDiameter: CGFloat = 75

    @ViewBuilder
    var initialsCircle: some View {
        ZStack {
            GeometryReader { geo in

                self.useProxy(geo)

                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [.systemGray3, .systemGray]
                            ),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(
                        width: circleDiameter,
                        height: circleDiameter
                    )

            }
            .background(Color.red)
            Text(user.initials)
                .font(.largeTitle)
                .foregroundColor(
                    .systemGroupedBackground
                )
        }
        .frame(width: 75, height: 75)
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                UserDetailView(user: PreviewUserRepository.users.first!)
            }

            NavigationView {
                UserDetailView(user: PreviewUserRepository.users.first!)
            }
            .preferredColorScheme(.dark)
        }
    }
}
