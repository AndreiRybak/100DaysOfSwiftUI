//
//  UserDetailView.swift
//  Challenge5
//
//  Created by Andrei Rybak on 25.07.22.
//

import SwiftUI

struct UserDetailView: View {
    @State var user: CachedUser
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text(user.wrappedName)
                        .font(.system(size: 32, weight: .heavy, design: .rounded))
                    VStack {
                        if user.isActive {
                            Text("Online")
                                .foregroundColor(.green)
                        } else {
                            Text("Offline")
                                .foregroundColor(.red)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                
                HStack {
                    Text(user.wrappedEmail)
                        .font(.system(size: 16, weight: .light))
                    Spacer()
                }
                
                HStack {
                    Text("Info")
                        .font(.system(size: 24, weight: .bold, design: .default))
                    Spacer()
                }
                .padding(.top, 24)
                
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Register date: \(user.wrappedRegistered.formatted(date: .numeric, time: .omitted))")
                        Text("Age: \(user.wrappedAge)")
                        Text("Address: \(user.wrappedAddress)")
                        Text("Company: \(user.wrappedCompany)")
                    }
                    .padding()
                    Spacer()
                }
                .background(Color(red: 61 / 255, green: 64 / 255, blue: 61 / 255))
                .cornerRadius(16)
                
                HStack {
                    Text("About")
                        .font(.system(size: 24, weight: .bold, design: .default))
                    Spacer()
                }
                .padding(.top, 24)
                
                Text(user.wrappedAbout)
                    .font(.body)
                    .padding(.top, 4)
                
                HStack {
                    Text("Friends")
                        .font(.system(size: 24, weight: .bold, design: .default))
                    Spacer()
                }
                .padding(.top, 24)
                
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(user.friendsArray) { friend in
                        Text(friend.wrappedName)
                            .padding()
                    }
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .frame(
                        minWidth: 60,
                        maxWidth: .infinity,
                        minHeight: 60,
                        maxHeight: .infinity
                    )
                    .background(Color(red: 61 / 255, green: 64 / 255, blue: 61 / 255))
                    .clipShape(Capsule())
                }
            }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
    }
    
}
