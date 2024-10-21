//
//  Destination.swift
//  MapKit_MapApp_SwiftUI
//
//  Created by wonyoul heo on 10/16/24.
//

import SwiftData
import MapKit

@Model
class Destination {
    var id: UUID
    var name: String
    var latitude: Double?
    var longitude: Double?
    var latitudeDelta: Double?
    var longitudeDelta: Double?
    @Relationship(deleteRule: .cascade)
    var placemarks: [MTPlacemark] = []
    
    init(name: String, latitude: Double? = nil, longitude: Double? = nil, latitudeDelta: Double? = nil, longitudeDelta: Double? = nil) {
        self.id = UUID()
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.latitudeDelta = latitudeDelta
        self.longitudeDelta = longitudeDelta
    }
    
    var region: MKCoordinateRegion? {
        if let latitude, let longitude, let latitudeDelta, let longitudeDelta {
            return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude) ,
                                      span: MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta))
        } else {
            return nil
        }
    }
}


extension Destination {
    
    // 프리뷰 볼 때 쓸 데이터 
    @MainActor
    static var preview: ModelContainer {
        let container = try! ModelContainer(
            for: Destination.self,
            configurations: ModelConfiguration(
                isStoredInMemoryOnly: true
            )
        )
        let myPostion = Destination(name: "광진구", latitude: 37.529917577563, longitude: 127.07609682971, latitudeDelta: 0.15, longitudeDelta: 0.15)
        
        container.mainContext.insert(myPostion)
        
        var placemarks: [MTPlacemark] {
            [
                MTPlacemark(name: "아차산", address: "광진구 아차산로 어쩌고", latitude: 37.5463621298, longitude: 127.10338548842),
                MTPlacemark(name: "건국대", address: "광진구 건국대 어쩌고", latitude: 37.540957955055, longitude: 127.08278172427)
            ]
        }
        
        placemarks.forEach { placemark in
            myPostion.placemarks.append(placemark)
        }
        
        return container
    }
}

// 아차산
//위도    37.5463621298
//경도    127.10338548842

// 건국대
//위도    37.540957955055
//경도    127.08278172427
