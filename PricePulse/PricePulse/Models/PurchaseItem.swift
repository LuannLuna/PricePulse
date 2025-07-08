//
//  PurchaseItem.swift
//  PricePulse
//
//  Created by Luann Luna on 04/07/25.
//

import Foundation
import SwiftData

@Model
class PurchaseItem: Identifiable {
    @Attribute(.unique)var id: String
    var quantity: Double
    var unitPrice: Double
    var tax: Double
    var total: Double

    @Relationship
    var product: Product

    @Relationship
    var purchase: Purchase

    init(id: String, quantity: Double, unitPrice: Double, tax: Double, total: Double, product: Product, purchase: Purchase) {
        self.id = id
        self.quantity = quantity
        self.unitPrice = unitPrice
        self.tax = tax
        self.total = total
        self.product = product
        self.purchase = purchase
    }
}

#if DEBUG
extension PurchaseItem {
    static var mock: PurchaseItem {
        let supermarket = Supermarket(cnpj: "12.345.678/0001-90", name: "Supermercado Exemplo")
        let purchase = Purchase(date: Date(), supermarket: supermarket)
        let product = Product(code: "123456789", name: "Arroz Integral", unit: "kg")

        let purchaseItem = PurchaseItem(
            id: "mock-item-1",
            quantity: 2.5,
            unitPrice: 8.99,
            tax: 1.35,
            total: 23.82,
            product: product,
            purchase: purchase
        )

        // Set up relationships
        purchase.items.append(purchaseItem)
        product.purchaseItems.append(purchaseItem)
        supermarket.purchases.append(purchase)

        return purchaseItem
    }
}
#endif // DEBUG
