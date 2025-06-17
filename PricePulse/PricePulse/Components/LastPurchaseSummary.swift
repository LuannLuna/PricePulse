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
            Text("Last Purchase Summary")
                .font(.headline)

            Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 8) {
                GridRow {
                    Text("Store:")
                    Text(purchase.store)
                }
                GridRow {
                    Text("Date:")
                    Text(purchase.date, style: .date)
                }
                GridRow {
                    Text("Unit Price:")
                    Text("R$\(purchase.unitPrice, specifier: "%.2f")")
                        .font(.title3)
                        .bold()
                }
                GridRow {
                    Text("Quantity:")
                    Text("\(purchase.quantity, specifier: "%.1f") \(purchase.unit)")
                }
                GridRow {
                    Text("Total Price:")
                    Text("R$\(purchase.totalPrice, specifier: "%.2f")")
                }
                GridRow {
                    Text("Tax:")
                    Text("R$\(purchase.tax, specifier: "%.2f")")
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
