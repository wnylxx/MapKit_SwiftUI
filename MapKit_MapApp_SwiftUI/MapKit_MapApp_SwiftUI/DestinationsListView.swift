//
//  DestinationListView.swift
//  MapKit_MapApp_SwiftUI
//
//  Created by wonyoul heo on 10/17/24.
//

import SwiftUI
import SwiftData

struct DestinationsListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Destination.name) private var destinations: [Destination]
    
    @State private var newDestination = false
    @State private var destinationName = ""
    
    var body: some View {
        NavigationStack {
            Group {
                if !destinations.isEmpty {
                    List(destinations) { destination in
                        HStack {
                            Image(systemName: "globe")
                                .imageScale(.large)
                                .foregroundStyle(.blue)
                            VStack(alignment: .leading) {
                                Text(destination.name)
                                // 2개 이상일 경우 s가 붙음
                                Text("^[\(destination.placemarks.count) location](inflect: true)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                modelContext.delete(destination)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                    
                } else {
                    ContentUnavailableView("No Destination",
                                           systemImage: "globe.desk",
                                           description: Text("You have not set up any destinations yet. Tap on the \(Image(systemName: "plus.circle.fill")) button in the toolbar to begin."))
                }
            }
            .navigationTitle("My Destinations")
            .toolbar {
                Button {
                    newDestination.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                .alert("Enter New Destination Name", isPresented: $newDestination) {
                    TextField("Enter New Destination Name", text: $destinationName)
                    
                    Button("OK") {
                        if !destinationName.isEmpty {
                            let destination = Destination(name: destinationName)
                            modelContext.insert(destination)
                            destinationName = ""
                        }
                    }
                    
                    Button("cancel", role: .cancel) {}
                    
                } message: {
                    Text("Create a new destination")
                }
            }
        }
        
    }
}

#Preview {
    DestinationsListView()
        .modelContainer(Destination.preview)
}
