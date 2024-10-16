//
//  MTPlacemark.swift
//  MapKit_MapApp_SwiftUI
//
//  Created by wonyoul heo on 10/16/24.
//

import SwiftData
import MapKit

@Model
class MTPlacemark {
    var name: String
    var address: String
    var latitude: Double
    var longitude: Double
    var destination: Destination? // 1:1 관계로 만들고 싶음.
    
    init(name: String, address: String, latitude: Double, longitude: Double) {
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
    
}
