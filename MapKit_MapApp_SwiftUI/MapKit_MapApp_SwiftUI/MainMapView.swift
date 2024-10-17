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
    @State private var visibleRegion: MKCoordinateRegion?
    var destination: Destination
    
    var body: some View {
        @Bindable var destination = destination
        VStack {
            LabeledContent {
                TextField("Enter destination name", text: $destination.name)
            } label: {
                Text("Name")
            }
            HStack {
                Text("Adjust the map to set the region for your destination.")
                    .foregroundStyle(.secondary)
                Spacer()
                Button("Set region") {
                    if let visibleRegion {
                        destination.latitude = visibleRegion.center.latitude
                        destination.longitude = visibleRegion.center.longitude
                        destination.latitudeDelta = visibleRegion.span.latitudeDelta
                        destination.longitudeDelta = visibleRegion.span.longitudeDelta
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        Map(position: $cameraPosition) {
            ForEach(destination.placemarks) { placemark in
                Marker(placemark.name, systemImage: "star", coordinate: placemark.coordinate)
            }
            .tint(.yellow)
            
        }
        .navigationTitle("Destination")
        .navigationBarTitleDisplayMode(.inline)
        .onMapCameraChange(frequency: .onEnd) { context in
            visibleRegion = context.region
        }
        .onAppear {
            if let region = destination.region {
                cameraPosition = .region(region)
            }
        }
    }
}

#Preview {
    let container = Destination.preview
    let fetchDescriptor = FetchDescriptor<Destination>()
    
    // 컨텍스트가 리셋되지 않았는지 확인 후, 안전하게 데이터를 가져오기
    if let destination = try? container.mainContext.fetch(fetchDescriptor).first {
        return NavigationStack {
            MainMapView(destination: destination)
        }
    } else {
        // 데이터가 없을 때나 오류가 발생할 경우에 대한 대처
        return Text("No destination available for preview.")
    }
}
