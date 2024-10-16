//
//  ContentView.swift
//  MapKit_MapApp_SwiftUI
//
//  Created by wonyoul heo on 10/14/24.
//

import SwiftUI
import MapKit
import SwiftData

struct MainMapView: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    @Query private var destinations: [Destination]
    @State private var destination: Destination?
    
    var body: some View {
        Map(position: $cameraPosition) {
            if let destination {
                ForEach(destination.placemarks) { placemark in
                    Marker(placemark.name, systemImage: "star", coordinate: placemark.coordinate)
                }
                .tint(.yellow)
            }
        }
            .onAppear {
                destination = destinations.first
                if let region = destination?.region {
                    cameraPosition = .region(region)
                }
            }
    }
}

#Preview {
    MainMapView()
        .modelContainer(Destination.preview)
}
