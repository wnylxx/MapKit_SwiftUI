//
//  ContentView.swift
//  MapKit_SwiftUI
//
//  Created by wonyoul heo on 10/9/24.
//

import SwiftUI
import MapKit

struct SearchableMapView: View {
    @ObservedObject private var viewModel: MapViewModel
    
    public init(onSelectResult: @escaping (SearchResult) -> Void) {
        self.viewModel = MapViewModel(searchService: SearchLocationServiceFactory.make(), onSelectResult: onSelectResult)
    }
    
    
    var body: some View {
        Map(position: $viewModel.position, interactionModes: .all) {
            if let selectedSearchLocation = viewModel.selectedSearchLocation {
                Marker(selectedSearchLocation.name, systemImage: "fork.knife", coordinate: selectedSearchLocation.coordinate)
                    .tint(.pink)
            }
        }
        .sheet(isPresented: .constant(true)) {
            SheetView(textFieldPlaceHolder: viewModel.searchPlaceHolder,
                      search: $viewModel.searchQuery,
                      selectedPresentationDetent: $viewModel.selectedPresentationDetent,
                      results: viewModel.searchResults,
                      didSelectResult: viewModel.didSelectResult(result:))
        }
    }
}

//#Preview {
//    SearchableMapView()
//}
