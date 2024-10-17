//
//  DestinationListView.swift
//  MapKit_MapApp_SwiftUI
//
//  Created by wonyoul heo on 10/17/24.
//

import SwiftUI
import SwiftData

struct DestinationsListView: View {
    
    @Query(sort: \Destination.name) private var destinations: [Destination]
    var body: some View {
        if !destinations.isEmpty {
            Text("hello world")
        } else {
            ContentUnavailableView("No Destination",
                                   systemImage: "globe.desk",
                                   description: Text("You have not set up any destinations yet. Tap on the \(Image(systemName: "plus.circle.fill")) button in the toolbar to begin."))
        }
    }
}

#Preview {
    DestinationsListView()
}
