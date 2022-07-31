//
//  PlaceSelectView.swift
//  PhotoList
//
//  Created by Andrei Rybak on 31.07.22.
//

import SwiftUI
import MapKit

struct PlaceSelectView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var locationFetcher = LocationFetcher()

    @Binding var latitude: Double?
    @Binding var longitude: Double?

    var body: some View {
        ZStack {
            Map(coordinateRegion: $locationFetcher.mapRegion)
                .onTapGesture {
                    print("Tap")
                }
            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 24, height: 24, alignment: .center)
            
        }
        .toolbar {
            Button("Save") {
                latitude = locationFetcher.mapRegion.center.latitude
                longitude = locationFetcher.mapRegion.center.longitude
                dismiss()
            }
        }
        .onAppear {
            locationFetcher.start()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PlaceSelectView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceSelectView(latitude: .constant(10), longitude: .constant(10))
    }
}
