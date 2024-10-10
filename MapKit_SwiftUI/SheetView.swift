//
//  SheetView.swift
//  MapKit_SwiftUI
//
//  Created by wonyoul heo on 10/9/24.
//

import SwiftUI

struct SheetView: View {
    @State private var locationService = LocationService(completer: .init())
    @State private var search: String = ""
    
    @Binding var searchResults: [SearchResult]
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "magnifyingglass")
                TextField("Search for a restaurant", text: $search)
                    .autocorrectionDisabled()
                    .onSubmit {
                        Task {
                            searchResults = (try? await locationService.search(with: search)) ?? []
                        }
                    }
            }
            .modifier(TextFieldGrayBackgroundColor())
            
            Spacer()
            
            List {
                ForEach(locationService.completions) { completion in
                    Button(action: {didTapOnCompletion(completion)} ) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(completion.title)
                                .font(.headline)
                                .fontDesign(.rounded)
                            Text(completion.subTitle)
                            if let url = completion.url {
                                Link(url.absoluteString, destination: url)
                                    .lineLimit(1)
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                    
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            
        }
        .onChange(of: search) {
            locationService.update(queryFragment: search)
        }
        .padding()
        // 아래로 내려서 dismiss 못하게 설정
        .interactiveDismissDisabled()
        .presentationDetents([.height(200), .large])
        // blur 효과 주기
        .presentationBackground(.regularMaterial)
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
        
    }
    
    private func didTapOnCompletion(_ completion: SearchCompletions) {
        Task {
            if let singleLocation = try? await locationService.search(with: "\(completion.title) \(completion.subTitle)").first {
                searchResults = [singleLocation]
            }
        }
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
