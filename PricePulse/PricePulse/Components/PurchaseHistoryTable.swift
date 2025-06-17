//
//  PurchaseHistoryTable.swift
//  PricePulse
//
//  Created by Luann Luna on 17/06/25.
//

import SwiftUI

struct PurchaseHistoryTable: View {
    let purchases: [PurchaseHistory]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(Strings.purchaseHistory)
                .font(.headline)

            ForEach(purchases) { purchase in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(purchase.date, style: .date)
                            .font(.subheadline)

                        Spacer()

                        Text(purchase.store)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }

                    HStack {
                        Text(String(format: "currency.format".localized, purchase.unitPrice))
                            .font(.headline)

                        Spacer()

                        Text(String(format: "quantity.format".localized, purchase.quantity, purchase.unit))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

#Preview {
    PurchaseHistoryTable(
        purchases: [
            .init(
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
            ),
            .init(
                id: "MCJ_20250531_091565",
                store: "MCJ SUPERMERCADOS LTDA",
                cnpj: "55.167.151/0002-01",
                date: Date(),
                productCode: "2025,91565",
                itemDescription: "BIFE DE FIGADO KG",
                quantity: 0.612,
                unit: "KG",
                unitPrice: 20.99,
                tax: 1.88,
                totalPrice: 12.62
            ),
            .init(
                id: "MCJ_20250531_091565",
                store: "MCJ SUPERMERCADOS LTDA",
                cnpj: "55.167.151/0002-01",
                date: Date(),
                productCode: "2025,91565",
                itemDescription: "BIFE DE FIGADO KG",
                quantity: 0.612,
                unit: "KG",
                unitPrice: 25.99,
                tax: 1.88,
                totalPrice: 12.62
            )
        ]
    )
}
