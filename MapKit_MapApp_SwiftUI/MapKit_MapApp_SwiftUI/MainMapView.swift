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
    
    var destination: Destination
    
    var body: some View {
        Map(position: $cameraPosition) {
            ForEach(destination.placemarks) { placemark in
                Marker(placemark.name, systemImage: "star", coordinate: placemark.coordinate)
            }
            .tint(.yellow)
            
        }
        .onAppear {
            if let region = destination.region {
                cameraPosition = .region(region)
            }
        }
    }
}

#Preview {
    // Query 사용하지말고 접근하기
    let container = Destination.preview
    let fetchDescriptor = FetchDescriptor<Destination>()
    let destination = try! container.mainContext.fetch(fetchDescriptor)[0]
    return MainMapView(destination: destination)
}
