//
//  PurchaseRow.swift
//  PricePulse
//
//  Created by Luann Luna on 17/06/25.
//

import SwiftUI

struct PurchaseRow: View {
    let purchase: PurchaseItem
    let previousPurchase: PurchaseItem?

    var priceChange: (percent: Double, absolute: Double)? {
        guard let previous = previousPurchase else { return nil }
        let absolute = purchase.unitPrice - previous.unitPrice
        let percent = previous.unitPrice == 0 ? 0 : (absolute / previous.unitPrice) * 100
        return (percent, absolute)
    }

    var priceChangeColor: Color? {
        guard let change = priceChange else { return nil }
        if change.absolute > 0 { return .red }
        if change.absolute < 0 { return .green }
        return .primary
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(purchase.product.name)
                .font(.headline)
                .lineLimit(2)
                .minimumScaleFactor(0.8)

            if let change = priceChange {
                HStack(spacing: 15) {
                    Text(String(format: "%+.0f%%", change.percent))
                    Text(Strings.currencyFormat.localized(abs(change.absolute)))
                }
                .font(.subheadline)
                .bold()
                .foregroundColor(priceChangeColor)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(priceChangeColor?.opacity(0.1) ?? Color.clear)
                .cornerRadius(6)
            } else {
                Text("First Purchase")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(6)
            }

            HStack {
                Text(
                    Strings.priceLabel.localized(
                        Strings.currencyFormat.localized(purchase.unitPrice)
                    )
                )
                    .font(.subheadline)
                    .bold()

                Spacer()

                Text(purchase.purchase.supermarket.name)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            HStack {
                Text(
                    Strings.dateLabel.localized(
                        purchase.purchase.date.formatted(
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
                        Strings.quantityFormat.localized(purchase.quantity, purchase.product.unit)
                    )
                )
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

//#if DEBUG
//#Preview {
//    List {
//        PurchaseRow(
//            purchase: .init(
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
//            previousPurchase: nil
//        )
//        PurchaseRow(
//            purchase: .init(
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
//            previousPurchase: .init(
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
//                totalPrice: 11.62
//            )
//        )
//    }
//    .listStyle(.sidebar)
//}
//#endif
