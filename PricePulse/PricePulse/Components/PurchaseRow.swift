//
//  PurchaseRow.swift
//  PricePulse
//
//  Created by Luann Luna on 17/06/25.
//

import SwiftUI

struct PurchaseRow: View {
    let purchase: PurchaseHistory

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(purchase.itemDescription)
                .font(.headline)
                .lineLimit(2)
                .minimumScaleFactor(0.8)

            HStack {
                Text(
                    Strings.priceLabel.localized(
                        Strings.currencyFormat.localized(purchase.unitPrice)
                    )
                )
                    .font(.subheadline)
                    .bold()

                Spacer()

                Text(purchase.store)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            HStack {
                Text(
                    Strings.dateLabel.localized(
                        purchase.date.formatted(
                            date: .abbreviated,
                            time: .omitted
                        )
                    )
                )
                    .font(.caption)
                    .foregroundColor(.secondary)

                Spacer()

                Text(
                    Strings.quantityLabel.localized(
                        Strings.quantityFormat.localized(purchase.quantity, purchase.unit)
                    )
                )
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    PurchaseRow(
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
    .padding()
}
