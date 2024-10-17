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
    var body: some Scene {
        WindowGroup {
            StartTab()
        }
        .modelContainer(for: Destination.self)
    }
}
