//
//  TripMapView.swift
//  MapKit_MapApp_SwiftUI
//
//  Created by wonyoul heo on 10/22/24.
//

import SwiftUI
import SwiftData
import MapKit

struct TripMapView: View {
    let manager = CLLocationManager()
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @Query private var listPlacemark: [MTPlacemark]
    var body: some View {
        Map(position: $cameraPosition) {
            UserAnnotation()
            ForEach(listPlacemark) {placemark in
                Marker(coordinate: placemark.coordinate) {
                    Label(placemark.name, systemImage: "star")
                }
                .tint(.yellow)
                
            }
        }
        .mapControls {
            MapUserLocationButton()
        }
        .onAppear {
            manager.requestAlwaysAuthorization()
        }
    }
}

#Preview {
    TripMapView()
}
