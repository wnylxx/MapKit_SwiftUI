//
//  se.swift
//  MapKit_SwiftUI
//
//  Created by wonyoul heo on 10/11/24.
//

import Foundation

enum SearchLocationServiceFactory {
    static func make() -> SearchLocationService {
        let dataAccess = MapKitDataAccess()
        return DefaultSearchLocationService(dataAccess: dataAccess)
    }
}

