import Foundation
import SwiftData

class CSVLoader {
    static func loadPurchaseHistory(from url: URL, modelContext: ModelContext) {
        do {
            // Load new data
            let csvString = try String(contentsOf: url, encoding: .utf8)
            let rows = csvString.components(separatedBy: .newlines)
            
            // Skip header row
            for row in rows.dropFirst() where !row.isEmpty {
                let columns = row.components(separatedBy: ",")
                guard columns.count >= 11 else { continue }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                
                guard let date = dateFormatter.date(from: columns[3]) else {
                    continue
                }

                let purchase = PurchaseHistory(
                    id: columns[0], // ID_Unico
                    store: columns[1], // Supermercado
                    cnpj: columns[2], // CNPJ
                    date: date, // Data_Compra
                    productCode: columns[4], // Código
                    itemDescription: columns[5], // Descrição
                    quantity: Double(columns[6]) ?? 0, // Qtde
                    unit: columns[7], // Un
                    unitPrice: Double(columns[8]) ?? 0, // Vl Unit
                    tax: Double(columns[9]) ?? 0, // Vl Tributo
                    totalPrice: Double(columns[10]) ?? 0 // Vl Total
                )
                
                modelContext.insert(purchase)
            }
            
            try modelContext.save()
        } catch {
            print("Error loading CSV: \(error)")
        }
    }
    
    private static func clearExistingData(modelContext: ModelContext) {
        do {
            let descriptor = FetchDescriptor<PurchaseHistory>()
            let existingPurchases = try modelContext.fetch(descriptor)
            
            for purchase in existingPurchases {
                modelContext.delete(purchase)
            }
            
            try modelContext.save()
        } catch {
            print("Error clearing existing data: \(error)")
        }
    }
} 
