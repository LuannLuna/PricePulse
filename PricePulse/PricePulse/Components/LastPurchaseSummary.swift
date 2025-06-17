//
//  LastPurchaseSummary.swift
//  PricePulse
//
//  Created by Luann Luna on 17/06/25.
//

import SwiftUI

struct LastPurchaseSummary: View {
    let purchase: PurchaseHistory

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(Strings.purchaseLastSummary)
                .font(.headline)

            Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 8) {
                GridRow {
                    Text(Strings.purchaseStore)
                    Text(purchase.store)
                }
                GridRow {
                    Text(Strings.purchaseDate)
                    Text(purchase.date, style: .date)
                }
                GridRow {
                    Text(Strings.purchaseUnitPrice)
                    Text(String(format: "currency.format".localized, purchase.unitPrice))
                        .font(.title3)
                        .bold()
                }
                GridRow {
                    Text(Strings.purchaseQuantity)
                    Text(String(format: "quantity.format".localized, purchase.quantity, purchase.unit))
                }
                GridRow {
                    Text(Strings.purchaseTotalPrice)
                    Text(String(format: "currency.format".localized, purchase.totalPrice))
                }
                GridRow {
                    Text(Strings.purchaseTax)
                    Text(String(format: "currency.format".localized, purchase.tax))
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

#Preview {
    LastPurchaseSummary(
        purchase: .init(
            id: "MCJ_20250531_091565",
            store: "MCJ SUPERMERCADOS LTDA",
            cnpj: "55.167.151/0002-01",
            date: Date(),
            productCode: "2025,91565",
            itemDescription: "BIFE DE FIGADO KG",
            quantity: 0.612,
            unit: "KG",
            unitPrice: 18.99,
            tax: 1.88,
            totalPrice: 11.62
        )
    )
}
