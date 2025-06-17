//
//  Item.swift
//  PricePulse
//
//  Created by Luann Luna on 16/06/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
