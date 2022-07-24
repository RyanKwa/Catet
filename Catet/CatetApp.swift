//
//  CatetApp.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 21/07/22.
//

import SwiftUI

@main
struct CatetApp: App {
//    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
