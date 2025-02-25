//
//  JournalAppApp.swift
//  JournalApp
//
//  Created by Adam Daniel Green on 2/25/25.
//

import SwiftUI

@main
struct JournalAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
