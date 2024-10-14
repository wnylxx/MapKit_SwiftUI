//
//  ContentView.swift
//  MapKit_SwiftUI
//
//  Created by wonyoul heo on 10/9/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var viewModel = MapViewModel()
    @State private var isSheetPresented: Bool = true
    
    
    var body: some View {
        VStack{
            Map(position: $viewModel.camaeraPosition, interactionModes: .all) {
                UserAnnotation()
            }
                
            .ignoresSafeArea()
            .sheet(isPresented: $isSheetPresented) { // sheet와 연동
                SheetView()
            }
            
        }
    }
}

#Preview {
    ContentView()
}
