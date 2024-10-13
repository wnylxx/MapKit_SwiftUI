//
//  ContentView.swift
//  MapKit_SwiftUI
//
//  Created by wonyoul heo on 10/9/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var isSheetPresented: Bool = true
    
    
    var body: some View {
        ZStack{
            Map() {
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
