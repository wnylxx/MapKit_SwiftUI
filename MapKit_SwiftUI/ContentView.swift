//
//  ContentView.swift
//  MapKit_SwiftUI
//
//  Created by wonyoul heo on 10/9/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    let locationManager = CLLocationManager()
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    @State private var isSheetPresented: Bool = true
    
    @State private var searchResults = [SearchResult]()
    @State private var selectedLocation: SearchResult?
    
    private let searchTitle = "검색어를 입력하세요."
    
    
    var body: some View {
        ZStack{
            Map(position: $position, selection: $selectedLocation) {
                UserAnnotation()
                ForEach(searchResults) { result in
                    Marker(coordinate: result.location) {
                        Image(systemName: "mappin")
                    }
                    .tag(result)
                }
            }
            .ignoresSafeArea()
            .onAppear {
                
            }
            .onChange(of: selectedLocation) {
                isSheetPresented = (selectedLocation == nil)
            }
            .onChange(of: searchResults) {
                if let firstResult = searchResults.first, searchResults.count == 1 {
                    selectedLocation = firstResult
                }
            }
            
            .sheet(isPresented: $isSheetPresented) {
                SheetView(searchResults: $searchResults)
            }
        }
    }
}

#Preview {
    ContentView()
}
