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
    @Environment(\.modelContext) private var modelContext
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var searchText = ""
    @FocusState private var searchFieldFocus: Bool
    @Query(filter: #Predicate<MTPlacemark> {$0.destination == nil}) private var searchPlacemarks: [MTPlacemark]
    private var listPlacemarks: [MTPlacemark] {
        searchPlacemarks + destination.placemarks
    }
    
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
            ForEach(listPlacemarks) { placemark in
                
                if placemark.destination != nil {
                    Marker(placemark.name, systemImage: "star", coordinate: placemark.coordinate)
                        .tint(.yellow)
                } else {
                    Marker(placemark.name, coordinate: placemark.coordinate)
                }
            }
            
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                TextField("Search...", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .focused($searchFieldFocus)
                    .overlay(alignment: .trailing){
                        if searchFieldFocus {
                            Button {
                                searchText = ""
                                searchFieldFocus = false
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                            }
                            .offset(x: -5)
                        }
                    }
                    .onSubmit {
                        Task {
                            await MapManager.searchPlaces(
                                modelContext,
                                searchText: searchText,
                                visibleRegion: visibleRegion
                            )
                            searchText = ""
                        }
                    }
                if !searchPlacemarks.isEmpty {
                    Button {
                        MapManager.removeSearchResults(modelContext)
                    } label: {
                        Image(systemName: "mappin.slash.circle.fill")
                            .imageScale(.large)
                    }
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(.red)
                    .clipShape(.circle)
                }
            }
            .padding()
        }
        .navigationTitle("Destination")
        .navigationBarTitleDisplayMode(.inline)
        .onMapCameraChange(frequency: .onEnd) { context in
            visibleRegion = context.region
        }
        .onAppear {
            MapManager.removeSearchResults(modelContext)
            if let region = destination.region {
                cameraPosition = .region(region)
            }
        }
        .onDisappear {
            MapManager.removeSearchResults(modelContext)
        }
    }
}

#Preview {
    let container = Destination.preview
    let fetchDescriptor = FetchDescriptor<Destination>()
    
    // 컨텍스트가 리셋되지 않았는지 확인 후, 안전하게 데이터를 가져오기
    if let destination = try? container.mainContext.fetch(fetchDescriptor)[0] {
        return NavigationStack {
            MainMapView(destination: destination)
        }
        .modelContainer(Destination.preview)
    } else {
        // 데이터가 없을 때나 오류가 발생할 경우에 대한 대처
        return Text("No destination available for preview.")
    }
    
}
