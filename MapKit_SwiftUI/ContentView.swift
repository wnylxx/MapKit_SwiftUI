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
    
    var body: some View {
        Map(position: $position)
            .ignoresSafeArea()
            .sheet(isPresented: $isSheetPresented) {
                SheetView()
            }
    }
}

//#Preview {
//    ContentView()
//}
