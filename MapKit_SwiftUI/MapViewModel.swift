//
//  MapViewModel.swift
//  MapKit_SwiftUI
//
//  Created by wonyoul heo on 10/10/24.
//

import SwiftUI
import MapKit
import Combine

class MapViewModel: ObservableObject {
    @Published var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var selectedPresentationDetent = PresentationDetent.height(150)
    @Published var selectedSearchLocation: SearchResult? = nil
    @Published var searchResults = [SearchResult]()
    @Published var searchQuery: String = ""
    
    let searchPlaceHolder: String = "지도 검색"
    let onSelectResult: (SearchResult) -> Void
    
    private let searchService: SearchLocationService
    private var cancellables = Set<AnyCancellable>()
    
    init(searchService: SearchLocationService, onSelectResult: @escaping (SearchResult) -> Void) {
        self.searchService = searchService
        self.onSelectResult = onSelectResult
        
        $searchQuery
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { query in
                self.search(with: query)
            }
            .store(in: &cancellables)
    }
    
    private func search(with query: String) {
        Task {
            let results = try await searchService.search(with: query)
            
            RunLoop.main.perform {
                self.searchResults = results
            }
        }
    }
    
    func didSelectResult(result: SearchResult) {
        selectedSearchLocation = result
        position = .item(.init(placemark: .init(coordinate: result.coordinate)))
        onSelectResult(result)
    }
    
}

