//
//  Preview.swift
//  PricePulse
//
//  Created by Luann Luna on 20/06/25.
//

import Foundation
import SwiftData

#if DEBUG
enum Previews {
    static let modelContainer = {
        let schema = Schema([
            Product.self,
            Purchase.self,
            PurchaseItem.self,
            Supermarket.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: [modelConfiguration])
        return container
    }()
}


@MainActor
func loadCSV() {
    if let csvURL = Bundle.main.url(forResource: "HistoricoCompras", withExtension: "csv") {
        CSVLoader.loadPurchaseHistory(from: csvURL, modelContext: Previews.modelContainer.mainContext)
    }
}
#endif
