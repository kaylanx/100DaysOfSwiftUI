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
                        cell(with: "Member since", for: "\(user.formattedRegistered)")
                    }
                    SectionView {
                        cell(with: "Age", for: "\(user.age)")
                    }
                    SectionView {
                        cell(with: "Email", for: user.email)
                        divider
                        cell(with: "Address", for: user.address)
                    }
                    SectionView {
                        cell(with: "About", for: user.about)
                    }
                    SectionView {
                        Text("Tags")
                            .font(.caption2)
                            .foregroundColor(.secondaryLabel)
                            .padding(.horizontal)
                            .padding(.top, 10)
                        ForEach(user.tags, id: \.self) { tag in
                            Text(tag)
                                .padding(.horizontal)
                                .padding(.top, user.tags.first == tag ? 10 : 0)
                                .padding(.bottom, user.tags.last == tag ? 10 : 0)
                            if user.tags.last != tag {
                                divider
                            }
                        }
                    }
                    SectionView {
                        Text("Friends")
                            .font(.caption2)
                            .foregroundColor(.secondaryLabel)
                            .padding(.horizontal)
                            .padding(.top, 10)
                        ForEach(user.friends) { friend in
                            Text(friend.name)
                                .padding(.horizontal)
                                .padding(.top, user.friends.first == friend ? 10 : 0)
                                .padding(.bottom, user.friends.last == friend ? 10 : 0)
                            if user.friends.last != friend {
                                divider
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
            .padding(.leading)
    }

    func cell(with title: String, for content: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondaryLabel)
            Text(content)
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
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
