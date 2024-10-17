//
//  StartTabl.swift
//  MapKit_MapApp_SwiftUI
//
//  Created by wonyoul heo on 10/17/24.
//

import SwiftUI

struct StartTab: View {
    var body: some View {
        TabView {
            Group {
                MainMapView()
                    .tabItem {
                        Label("TripMap", systemImage: "map")
                    }
                DestinationsListView()
                    .tabItem {
                        Label("Destination", systemImage: "globe.desk")
                    }
            }
        }
    }
}

#Preview {
    StartTab()
}
