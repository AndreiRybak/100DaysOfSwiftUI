//
//  PhotoDetailView.swift
//  PhotoList
//
//  Created by Andrei Rybak on 31.07.22.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    var id = UUID()
    var coordinate: CLLocationCoordinate2D
}

struct PhotoDetailView: View {
    @State var photo: Photo
    @State var mapRegion: MKCoordinateRegion

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center) {
                Image(uiImage: photo.image)
                    .resizable()
                    .scaledToFit()
            }

            VStack(alignment: .leading, spacing: 8) {
                if mapRegion.center.latitude != 0.0 && mapRegion.center.longitude != 0.0 {
                    Map(coordinateRegion: $mapRegion, annotationItems: [Location(coordinate: photo.coordinate!)]) { location in
                        MapAnnotation(coordinate: location.coordinate) {
                            VStack {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundColor(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(Circle())
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 32, height: 300)
                }
                Text(photo.title)
                    .font(.headline)
                Text(photo.description)
                    .font(.subheadline)
                    .padding(.bottom)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .onAppear {
            if photo.coordinate != nil {
                mapRegion = MKCoordinateRegion(center: photo.coordinate!, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
            } else {
                mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
            }
        }
    }
}

//struct PhotoDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoDetailView(photo: Photo(image: UIImage(), title: "", description: ""))
//    }
//}
