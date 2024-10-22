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
                TripMapView()
                    .tabItem {
                        Label("Trip", systemImage: "airplane.departure" )
                    }

                DestinationsListView()
                    .tabItem {
                        Label("Destination", systemImage: "globe.desk")
                    }
            }
            .toolbarBackground(.blue.opacity(0.8), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

#Preview {
    StartTab()
        .modelContainer(Destination.preview)
}
