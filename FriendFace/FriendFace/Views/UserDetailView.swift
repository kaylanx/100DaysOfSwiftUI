//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Andy Kayley on 08/07/2022.
//

import SwiftUI

struct UserDetailView: View {

    private struct Constants {
        static let defaultCircleDiameter: CGFloat = 75
        static let defaultFontSize: CGFloat = 35

    }

    var user: User
    @State private var circleDiameter: CGFloat = Constants.defaultCircleDiameter
    @State private var textSize: CGFloat = Constants.defaultFontSize
    @State private var isShowingNativeTitle = false

    var body: some View {
        ZStack {
            Color.systemGroupedBackground
            ScrollViewOffset { offset in

                withAnimation {
                    isShowingNativeTitle = offset <= -73.0
                }

                let circleScale = 1.0 - (min(Constants.defaultCircleDiameter, -offset) / Constants.defaultCircleDiameter)
                circleDiameter = Constants.defaultCircleDiameter * circleScale

                let textScale = 1.0 - (min(Constants.defaultFontSize, -offset) / Constants.defaultFontSize)
                textSize = Constants.defaultFontSize * textScale

            } content: {
                LazyVStack(alignment: .center) {
                    initialsCircle
                        .padding(.top)

                    if isShowingNativeTitle == false {
                        Text(user.name)
                            .font(.largeTitle)
                    }

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
        .navigationBarTitle(Text(isShowingNativeTitle ? user.name : ""))
        .background(Color.systemGroupedBackground)
    }

    @ViewBuilder
    var initialsCircle: some View {
        ZStack(alignment: .center) {
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
            Text(user.initials)
                .foregroundColor(
                    .systemGroupedBackground
                )
                .font(.system(size: textSize))
        }
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
