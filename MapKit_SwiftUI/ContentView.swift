//
//  ContentView.swift
//  MapKit_SwiftUI
//
//  Created by wonyoul heo on 10/9/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var position = MapCameraPosition.automatic
    @State private var isSheetPresented: Bool = false
    
    @State private var searchResults = [SearchResult]()
    @State private var selectedLocation: SearchResult?
    
    private let searchTitle = "검색어를 입력하세요."
    
    
    var body: some View {
        ZStack{
            Map(position: $position, selection: $selectedLocation) {
                ForEach(searchResults) { result in
                    Marker(coordinate: result.location) {
                        Image(systemName: "mappin")
                    }
                    .tag(result)
                }
            }
            .ignoresSafeArea()
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
            
            VStack{
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color.gray)
                        .padding()
                    Text("\(searchTitle)")
                        .foregroundStyle(Color.gray)
                        .onTapGesture {
                            isSheetPresented = true
                        }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(8)
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
