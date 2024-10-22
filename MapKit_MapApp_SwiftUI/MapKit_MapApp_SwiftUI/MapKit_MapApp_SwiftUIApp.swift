//
//  MapKit_MapApp_SwiftUIApp.swift
//  MapKit_MapApp_SwiftUI
//
//  Created by wonyoul heo on 10/14/24.
//

import SwiftUI
import SwiftData

@main
struct MapKit_MapApp_SwiftUIApp: App {
    @State private var locationManager = LocationManager()
    var body: some Scene {
        WindowGroup {
            if locationManager.isAuthorized {
                StartTab()
            } else {
                LocationDeniedView()
            }
          
        }
        .modelContainer(for: Destination.self)
        .environment(locationManager)
    }
}
