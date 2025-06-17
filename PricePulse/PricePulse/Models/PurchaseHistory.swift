import Foundation
import SwiftData

@Model
final class PurchaseHistory: Identifiable {
    @Attribute(.unique) var id: UUID
    var date: Date
    var store: String
    var productCode: String
    var itemDescription: String
    var quantity: Double
    var unit: String
    var unitPrice: Double
    var totalPrice: Double
    var tax: Double
    var category: String
    
    init(date: Date, store: String, productCode: String, itemDescription: String, quantity: Double, unit: String, unitPrice: Double, totalPrice: Double, tax: Double, category: String) {
        self.date = date
        self.store = store
        self.productCode = productCode
        self.itemDescription = itemDescription
        self.quantity = quantity
        self.unit = unit
        self.unitPrice = unitPrice
        self.totalPrice = totalPrice
        self.tax = tax
        self.category = category
        self.id = UUID(uuidString: productCode) ?? .init()
    }
}
