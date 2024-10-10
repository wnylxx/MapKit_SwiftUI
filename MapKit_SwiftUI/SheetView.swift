//
//  SheetView.swift
//  MapKit_SwiftUI
//
//  Created by wonyoul heo on 10/9/24.
//

import SwiftUI
import CoreLocation

struct SearchResult: Identifiable {
    let name: String
    let title: String
    let id: UUID
    let coordinate: CLLocationCoordinate2D
    
    init(name: String, title: String, id: UUID, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.title = title
        self.id = id
        self.coordinate = coordinate
    }
    
}

struct SheetView: View {
    let textFieldPlaceHolder: String
    @Binding var search: String
    @Binding var selectedPresentationDetent: PresentationDetent
    let results: [SearchResult]
    let didSelectResult: (SearchResult) -> Void
    
    @FocusState private var isTextFieldFocused: Bool
    
    //    @State private var locationService = LocationService(completer: .init())
    //    @State private var search: String = ""
    
    //    @Binding var searchResults: [SearchResult]
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "magnifyingglass")
                TextField(textFieldPlaceHolder, text: $search)
                    .focused($isTextFieldFocused)
            }
            .modifier(TextFieldGrayBackgroundColor())
            
            if results.isEmpty {
                ContentUnavailableView("Get started by searching for a restaurant", systemImage: "fork.knife")
            } else {
                List {
                    ForEach(results) { result in
                        Button(action: {isTextFieldFocused = false; didSelectResult(result) }) {
                            VStack(alignment: .leading, spacing: 8){
                                Text(result.name)
                                    .font(.headline)
                                Text(result.title)
                            }
                        }
                        .listRowBackground(Color.clear)
                        .foregroundStyle(.primary)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            
            Spacer()
        }
        .onChange(of: isTextFieldFocused) { selectedPresentationDetent = isTextFieldFocused ? .large : .height(300) }
        .padding()
        .presentationDetents([.height(200), .large], selection: $selectedPresentationDetent)
        .presentationBackground(.regularMaterial)
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
        .interactiveDismissDisabled()
        
    }
}






struct TextFieldGrayBackgroundColor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .background(.gray.opacity(0.1))
            .cornerRadius(8)
            .foregroundStyle(.primary)
    }
}

//#Preview {
//    SheetView()
//}
