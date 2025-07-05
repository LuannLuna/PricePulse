//
//  Supermarket.swift
//  PricePulse
//
//  Created by Luann Luna on 04/07/25.
//

import SwiftData

@Model
class Supermarket {
    @Attribute(.unique) var cnpj: String
    var name: String

    @Relationship(inverse: \Purchase.supermarket)
    var purchases: [Purchase] = []

    init(cnpj: String, name: String) {
        self.cnpj = cnpj
        self.name = name
    }
}
