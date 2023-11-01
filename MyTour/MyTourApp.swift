//
//  MyTourApp.swift
//  MyTour
//
//  Created by André Porto on 01/11/23.
//

import SwiftUI
import SwiftData

@main
struct MyTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
