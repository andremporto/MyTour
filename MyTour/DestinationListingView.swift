//
//  DestinationListingView.swift
//  MyTour
//
//  Created by André Porto on 01/11/23.
//

import SwiftData
import SwiftUI

struct DestinationListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Destination.priority, order: .reverse),
        SortDescriptor(\Destination.name)]) var destinations: [Destination]
    
    var body: some View {
        List {
            ForEach(destinations) { destination in
                NavigationLink(value: destination) {
                    VStack(alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)
                        
                        Text(destination.date.formatted(date: .long, time: .shortened))
                    }
                }
            }
            .onDelete(perform: deleteDestinations)
        }
    }
    init(sort: SortDescriptor<Destination>, seachString: String) {
        _destinations = Query(filter: #Predicate {
            if seachString.isEmpty {
                return true
            } else {
                return $0.name.localizedStandardContains(seachString)
            }
        }, sort: [sort])
    }
    
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name), seachString: "")
}
