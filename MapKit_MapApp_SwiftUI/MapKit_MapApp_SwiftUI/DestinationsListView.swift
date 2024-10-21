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
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if !destinations.isEmpty {
                    List(destinations) { destination in
                        NavigationLink(value: destination) {
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
                    }
                    .navigationDestination(for: Destination.self) { destination in
                        MainMapView(destination: destination)
                        
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
                        .autocorrectionDisabled()
                    Button("OK") {
                        if !destinationName.isEmpty {
                            let destination = Destination(name: destinationName.trimmingCharacters(in: .whitespacesAndNewlines))
                            modelContext.insert(destination)
                            destinationName = ""
                            path.append(destination)
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
