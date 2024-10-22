//
//  TripMapView.swift
//  MapKit_MapApp_SwiftUI
//
//  Created by wonyoul heo on 10/22/24.
//

import SwiftUI
import MapKit

struct TripMapView: View {
    let manager = CLLocationManager()
    var body: some View {
        Map() {
            UserAnnotation()
        }
        .onAppear {
            manager.requestAlwaysAuthorization()
        }
    }
}

//#Preview {
//    TripMapView()
//}
