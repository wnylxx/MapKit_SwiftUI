//
//  LocationManager.swift
//  MapKit_MapApp_SwiftUI
//
//  Created by wonyoul heo on 10/22/24.
//

import SwiftUI
import CoreLocation

@Observable
class LocationManager {
    @ObservationIgnored let manager = CLLocationManager()
    var userLocation: CLLocation?
    var isAuthorized = false
    
    init() {
        startLocationService()
    }
    
    func startLocationService() {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
            manager.startUpdatingLocation()
            isAuthorized = true
        } else {
            isAuthorized = false
            manager.requestWhenInUseAuthorization()
        }
    }
}
