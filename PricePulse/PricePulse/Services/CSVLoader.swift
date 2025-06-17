import Foundation
import SwiftData

class CSVLoader {
    static func loadPurchaseHistory(from url: URL, modelContext: ModelContext) {
        do {
            let csvString = try String(contentsOf: url, encoding: .utf8)
            let rows = csvString.components(separatedBy: .newlines)
            
            // Skip header row
            for row in rows.dropFirst() where !row.isEmpty {
                let columns = row.components(separatedBy: ",")
                guard columns.count >= 10 else { continue }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                guard let date = dateFormatter.date(from: columns[0]) else { continue }
                
                let purchase = PurchaseHistory(
                    date: date,
                    store: columns[1],
                    productCode: columns[2],
                    itemDescription: columns[3],
                    quantity: Double(columns[4]) ?? 0,
                    unit: columns[5],
                    unitPrice: Double(columns[6]) ?? 0,
                    totalPrice: Double(columns[7]) ?? 0,
                    tax: Double(columns[8]) ?? 0,
                    category: columns[9]
                )
                
                modelContext.insert(purchase)
            }
            
            try modelContext.save()
        } catch {
            print("Error loading CSV: \(error)")
        }
    }
} 
