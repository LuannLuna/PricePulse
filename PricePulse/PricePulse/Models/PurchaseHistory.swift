import Foundation
import SwiftData

@Model
final class PurchaseHistory: Identifiable {
    @Attribute(.unique) var id: String
    var store: String
    var cnpj: String
    var date: Date
    var productCode: String
    var itemDescription: String
    var quantity: Double
    var unit: String
    var unitPrice: Double
    var tax: Double
    var totalPrice: Double
    
    init(id: String, store: String, cnpj: String, date: Date, productCode: String, 
         itemDescription: String, quantity: Double, unit: String, unitPrice: Double, 
         tax: Double, totalPrice: Double) {
        self.id = id
        self.store = store
        self.cnpj = cnpj
        self.date = date
        self.productCode = productCode
        self.itemDescription = itemDescription
        self.quantity = quantity
        self.unit = unit
        self.unitPrice = unitPrice
        self.tax = tax
        self.totalPrice = totalPrice
    }
}
