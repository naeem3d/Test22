//
//  ProjectSwiftData2App.swift
//  ProjectSwiftData2
//
//  Created by naeem alabboodi on 2/15/24.
//

import SwiftUI
import SwiftData

@main
struct ProjectSwiftData2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
