//
//  ContentView.swift
//  MyTour
//
//  Created by André Porto on 01/11/23.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [Destination]()
    @State private var sortOrder = SortDescriptor(\Destination.name)
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            DestinationListingView(sort: sortOrder, seachString: searchText)
                .navigationTitle("MyTour")
                .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
                .searchable(text: $searchText)
                .toolbar {
                    Button("Adicionar Destino", systemImage: "plus", action: addDestination)
                    
                    Menu("Escolher", systemImage: "arrow.up.arrow.down") {
                        Picker("Escolher", selection: $sortOrder) {
                            Text("Nome")
                                .tag(SortDescriptor(\Destination.name))
                            
                            Text("Prioridade")
                                .tag(SortDescriptor(\Destination.priority, order: .reverse))
                            
                            Text("Data")
                                .tag(SortDescriptor(\Destination.date))
                        }
                        .pickerStyle(.inline)
                    }
                }
        }
    }
    
    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
}

#Preview {
    ContentView()
}
