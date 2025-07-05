//
//  Product.swift
//  PricePulse
//
//  Created by Luann Luna on 04/07/25.
//

import SwiftData

@Model
class Product {
    @Attribute(.unique) var code: String // Código do produto
    var name: String
    var unit: String

    @Relationship(inverse: \PurchaseItem.product)
    var purchaseItems: [PurchaseItem] = []

    init(code: String, name: String, unit: String) {
        self.code = code
        self.name = name
        self.unit = unit
    }
}
