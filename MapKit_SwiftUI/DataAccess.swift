//
//  DataAccess.swift
//  MapKit_SwiftUI
//
//  Created by wonyoul heo on 10/11/24.
//

protocol DataAccess<Request, Response> {
    associatedtype Request
    associatedtype Response
    
    func fetch(request: Request) async throws -> Response
}
