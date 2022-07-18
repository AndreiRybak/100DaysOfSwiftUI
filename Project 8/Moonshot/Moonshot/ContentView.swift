//
//  ContentView.swift
//  Moonshot
//
//  Created by Andrei Rybak on 18.07.22.
//

import SwiftUI

struct MissionListView: View {
    
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astrounauts: astronauts)
                    } label: {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                                .background(.lightBackground)
                            
                            VStack(alignment: .leading, spacing: 4) {
        
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }

                            Spacer()
                        }
                        .background(.lightBackground)
                        .cornerRadius(10)
                    }
                }
                .padding([.horizontal])
            }
        }
    }
}

struct MissionGridView: View {

    let missions: [Mission]
    let astronauts: [String: Astronaut]

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astrounauts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                             
                            VStack {
        
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}


struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingAsList = true

    var body: some View {
        NavigationView {
            Group {
                if showingAsList {
                    MissionListView(missions: missions, astronauts: astronauts)
                } else {
                    ScrollView {
                        MissionGridView(missions: missions, astronauts: astronauts)
                    }
                }
            }
            .background(.darkBackground)
            .navigationTitle("Moonshot")
            .preferredColorScheme(.dark)
            .toolbar {
                Button {
                    showingAsList.toggle()
                } label: {
                    Image(systemName: showingAsList ? "square.grid.2x2" : "list.dash")
                }
                .tint(.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
