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
    @Environment(LocationManager.self) var locationManager
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
        .onAppear {
            updateCameraPosition()
        }
        .mapControls {
            MapUserLocationButton()
        }
    }
    
    func updateCameraPosition() {
        if let userLocation = locationManager.userLocation {
            let userRegion = MKCoordinateRegion(
                center: userLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
            )
            withAnimation {
                cameraPosition = .region(userRegion)
            }
        }
    }
}

#Preview {
    TripMapView()
        .environment(LocationManager())
}
