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
                        divider
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
                            ForEach(user.tags, id: \.self) { tag in
                                Text(tag)
                                    .padding(.bottom, user.tags.last == tag ? 10 : 0)
                                if user.tags.last != tag {
                                    divider
                                }
                            }
                        }
                    }
                    SectionView {
                        SectionCell(title: "Friends") {
                            ForEach(user.friends) { friend in
                                Text(friend.name)
                                    .padding(.bottom, user.friends.last == friend ? 10 : 0)
                                if user.friends.last != friend {
                                    divider
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.systemGroupedBackground)
    }

    @ViewBuilder private var divider: some View {
        Divider()
            .foregroundColor(.secondaryLabel)
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
