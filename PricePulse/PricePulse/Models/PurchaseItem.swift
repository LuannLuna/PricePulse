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
