//
//  PurchaseHistoryTable.swift
//  PricePulse
//
//  Created by Luann Luna on 17/06/25.
//

import SwiftUI

struct PurchaseHistoryTable: View {
    let purchases: [PurchaseItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(Strings.purchaseHistory)
                .font(.headline)

            ForEach(Array(purchases.sorted(by: { $0.purchase.date < $1.purchase.date }).enumerated()), id: \.offset) { idx, purchase in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(purchase.purchase.date, style: .date)
                            .font(.subheadline)

                        Spacer()

                        Text(purchase.purchase.supermarket.name)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }

                    HStack {
                        Text(Strings.currencyFormat.localized(purchase.unitPrice))
                            .font(.headline)

                        Spacer()

                        Text(Strings.quantityFormat.localized(purchase.quantity, purchase.product.unit))
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

//#Preview {
//    PurchaseHistoryTable(
//        purchases: [
//            .init(
//                id: "MCJ_20250531_091565",
//                store: "MCJ SUPERMERCADOS LTDA",
//                cnpj: "55.167.151/0002-01",
//                date: Date(),
//                productCode: "2025,91565",
//                itemDescription: "BIFE DE FIGADO KG",
//                quantity: 0.612,
//                unit: "KG",
//                unitPrice: 18.99,
//                tax: 1.88,
//                totalPrice: 11.62
//            ),
//            .init(
//                id: "MCJ_20250531_091565",
//                store: "MCJ SUPERMERCADOS LTDA",
//                cnpj: "55.167.151/0002-01",
//                date: Date(),
//                productCode: "2025,91565",
//                itemDescription: "BIFE DE FIGADO KG",
//                quantity: 0.612,
//                unit: "KG",
//                unitPrice: 20.99,
//                tax: 1.88,
//                totalPrice: 12.62
//            ),
//            .init(
//                id: "MCJ_20250531_091565",
//                store: "MCJ SUPERMERCADOS LTDA",
//                cnpj: "55.167.151/0002-01",
//                date: Date(),
//                productCode: "2025,91565",
//                itemDescription: "BIFE DE FIGADO KG",
//                quantity: 0.612,
//                unit: "KG",
//                unitPrice: 25.99,
//                tax: 1.88,
//                totalPrice: 12.62
//            )
//        ]
//    )
//}
