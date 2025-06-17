import Foundation

struct ProductPurchase: Identifiable, Codable {
    let id: UUID
    let date: Date
    let store: String
    let productCode: String
    let productName: String
    let quantity: Double
    let unit: String
    let unitPrice: Double
    let totalPrice: Double
    let tax: Double
    let category: String
    
    init(id: UUID = UUID(), date: Date, store: String, productCode: String, productName: String,
         quantity: Double, unit: String, unitPrice: Double, totalPrice: Double, tax: Double, category: String) {
        self.id = id
        self.date = date
        self.store = store
        self.productCode = productCode
        self.productName = productName
        self.quantity = quantity
        self.unit = unit
        self.unitPrice = unitPrice
        self.totalPrice = totalPrice
        self.tax = tax
        self.category = category
    }
}

// Extension to handle CSV parsing
extension ProductPurchase {
    static func fromCSVRow(_ row: [String]) -> ProductPurchase? {
        guard row.count >= 10,
              let date = DateFormatter.csvDateFormatter.date(from: row[0]) else {
            return nil
        }
        
        return ProductPurchase(
            date: date,
            store: row[1],
            productCode: row[2],
            productName: row[3],
            quantity: Double(row[4]) ?? 0,
            unit: row[5],
            unitPrice: Double(row[6]) ?? 0,
            totalPrice: Double(row[7]) ?? 0,
            tax: Double(row[8]) ?? 0,
            category: row[9]
        )
    }
}

// Helper extension for date formatting
extension DateFormatter {
    static let csvDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
} 