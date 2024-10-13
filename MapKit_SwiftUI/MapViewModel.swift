//
//  MapViewModel.swift
//  MapKit_SwiftUI
//
//  Created by wonyoul heo on 10/13/24.
//

import Foundation
import SwiftUI
import MapKit


class MapViewModel: NSObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager = CLLocationManager()
    
    var camaeraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func moveToCurrentLocation() {
        self.camaeraPosition = .userLocation(fallback: .automatic)
    }
    
}
