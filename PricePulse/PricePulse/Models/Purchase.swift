//
//  Purchase.swift
//  PricePulse
//
//  Created by Luann Luna on 04/07/25.
//

import Foundation
import SwiftData

@Model
class Purchase {
    var date: Date

    @Relationship
    var supermarket: Supermarket

    @Relationship(inverse: \PurchaseItem.purchase)
    var items: [PurchaseItem] = []

    init(date: Date, supermarket: Supermarket) {
        self.date = date
        self.supermarket = supermarket
    }
}
