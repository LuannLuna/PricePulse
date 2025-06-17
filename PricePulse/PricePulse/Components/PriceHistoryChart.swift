//
//  PriceHistoryChart.swift
//  PricePulse
//
//  Created by Luann Luna on 17/06/25.
//

import SwiftUI
import Charts

struct PriceHistoryChart: View {
    let purchases: [PurchaseHistory]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Price History")
                .font(.headline)

            Chart {
                ForEach(purchases) { purchase in
                    LineMark(
                        x: .value("Date", purchase.date),
                        y: .value("Price", purchase.unitPrice)
                    )
                    .foregroundStyle(.blue)

                    PointMark(
                        x: .value("Date", purchase.date),
                        y: .value("Price", purchase.unitPrice)
                    )
                    .foregroundStyle(.blue)
                }
            }
            .frame(height: 200)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

#Preview {
    PriceHistoryChart(purchases: [
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
    ])
}
