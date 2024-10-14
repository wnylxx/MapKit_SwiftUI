//
//  MapViewModel.swift
//  MapKit_SwiftUI
//
//  Created by wonyoul heo on 10/13/24.
//

import Foundation
import SwiftUI
import MapKit


class MapViewModel: NSObject, ObservableObject ,CLLocationManagerDelegate {
    private let locationManager: CLLocationManager = CLLocationManager()
    
    var camaeraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.first else { return }
        
        self.camaeraPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
    }
    
}
