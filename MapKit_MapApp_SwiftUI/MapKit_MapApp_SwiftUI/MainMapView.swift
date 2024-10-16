//
//  ContentView.swift
//  MapKit_MapApp_SwiftUI
//
//  Created by wonyoul heo on 10/14/24.
//

import SwiftUI
import MapKit

struct MainMapView: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    var body: some View {
        Map(position: $cameraPosition) {
            Marker("My Home", coordinate: CLLocationCoordinate2D(latitude: 37.529917577563, longitude: 127.07609682971))
        }
            .onAppear {
                // 신자초 위도 37.529917577563 , 경도 127.07609682971
                let myPosition = CLLocationCoordinate2D(latitude: 37.529917577563, longitude: 127.07609682971)
                let mySpan = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
                let myRegion = MKCoordinateRegion(center: myPosition, span: mySpan)
                cameraPosition = .region(myRegion)
            }
    }
}

#Preview {
    MainMapView()
}
