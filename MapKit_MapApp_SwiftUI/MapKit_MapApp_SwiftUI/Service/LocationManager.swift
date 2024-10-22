//
//  LocationManager.swift
//  MapKit_MapApp_SwiftUI
//
//  Created by wonyoul heo on 10/22/24.
// CLLocationManagerDelegate 쓸려면 NSObject 추가해야함
// delegate를 쓴 이유는 사용자의 위치 변화를 계속 받기 위해

import SwiftUI
import CoreLocation

@Observable
class LocationManager: NSObject,CLLocationManagerDelegate {
    @ObservationIgnored let manager = CLLocationManager()
    var userLocation: CLLocation?
    var isAuthorized = false
    
    override init() {
        super.init()
        manager.delegate = self
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
    }
    
    // MARK: - 사용자 위치 확인 권한 요청
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            isAuthorized = true
            manager.requestLocation()
        case .notDetermined:
            isAuthorized = false
            manager.requestWhenInUseAuthorization()
        case .denied:
            isAuthorized = false
            print("access denied")
        default:
            isAuthorized = true
            startLocationService()
        }
    }
    
    // MARK: - 에러 발생
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
}

