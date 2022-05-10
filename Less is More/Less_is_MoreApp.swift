//
//  Less_is_MoreApp.swift
//  Less is More
//
//  Created by Blaine on 5/9/22.
//

import SwiftUI

@main
struct Less_is_MoreApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
