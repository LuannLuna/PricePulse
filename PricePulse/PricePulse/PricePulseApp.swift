//
//  PricePulseApp.swift
//  PricePulse
//
//  Created by Luann Luna on 16/06/25.
//

import SwiftUI
import SwiftData

@main
struct PricePulseApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            PurchaseHistory.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RouterView {
                HomeView()
            }
            .onAppear {
                if let csvURL = Bundle.main.url(forResource: "HistoricoCompras", withExtension: "csv") {
                    CSVLoader.loadPurchaseHistory(from: csvURL, modelContext: sharedModelContainer.mainContext)
                } else {
                    print("CSV file not found.")
                }
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
