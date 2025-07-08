//
//  Strings.swift
//  PricePulse
//
//  Created by Luann Luna on 17/06/25.
//

import Foundation

enum Strings: String {
    // App
    case appTitle = "app.title"

    // Statistics
    case statistics = "statistics"
    case selectMonth = "select.month"
    case monthlyTotal = "monthly.total"
    case totalPerStore = "total.per.store"
    case storeBreakdown = "store.breakdown"
    case month
    case year
    case store
    case total

    // Search
    case searchPrompt = "search.prompt"

    // Purchase Details
    case purchaseLastSummary = "purchase.last.summary"
    case purchaseStore = "purchase.store"
    case purchaseDate = "purchase.date"
    case purchaseUnitPrice = "purchase.unit.price"
    case purchaseQuantity = "purchase.quantity"
    case purchaseTotalPrice = "purchase.total.price"
    case purchaseTax = "purchase.tax"

    // Price History
    case priceHistory = "price.history"
    case priceHistoryChart = "price.history.chart"

    // Purchase History
    case purchaseHistory = "purchase.history"
    case purchaseHistoryTable = "purchase.history.table"

    // Format
    case currencyFormat = "currency.format"
    case quantityFormat = "quantity.format"
    case priceLabel = "price.label"
    case quantityLabel = "quantity.label"
    case dateLabel = "date.label"

    // Comparison
    case comparisonTitle = "comparison.title"
    case comparisonProductA = "comparison.product.a"
    case comparisonProductB = "comparison.product.b"
    case comparisonSection = "comparison.section"
    case comparisonName = "comparison.name"
    case comparisonUnitsPerPackage = "comparison.units.per.package"
    case comparisonAmountPerUnit = "comparison.amount.per.unit"
    case comparisonAmountUnit = "comparison.amount.unit"
    case comparisonPrice = "comparison.price"
    case comparisonBetterValue = "comparison.better.value"
    case comparisonSameValue = "comparison.same.value"
    case comparisonPerBaseUnit = "comparison.per.base.unit"
    
    case comparisonDisplayMilliliter = "comparison.display.milliliter"
    case comparisonDisplayLiter = "comparison.display.liter"
    case comparisonDisplayGram = "comparison.display.gram"
    case comparisonDisplayKilogram = "comparison.display.kilogram"
    case comparisonDisplayMeter = "comparison.display.meter"
    case comparisonDisplayUnit = "comparison.display.unit"
}
