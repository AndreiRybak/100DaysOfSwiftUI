//
//  ContentView.swift
//  Challenge5
//
//  Created by Andrei Rybak on 25.07.22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc

    @FetchRequest(entity: CachedUser.entity(), sortDescriptors: []) var users: FetchedResults<CachedUser>

    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    NavigationLink {
                        UserDetailView(user: user)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(user.wrappedName)
                                .font(.headline)
                            Text(user.isActive ? "Online" : "Offline")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Users")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
