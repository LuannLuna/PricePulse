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
    @Binding var selectedPurchase: PurchaseHistory?
    @Binding var showPopup: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(Strings.priceHistory)
                .font(.headline)

            Chart {
                ForEach(purchases) { purchase in
                    LineMark(
                        x: .value(Strings.purchaseDate.localized(), purchase.date),
                        y: .value(Strings.purchaseUnitPrice.localized(), purchase.unitPrice)
                    )
                    .foregroundStyle(.blue)

                    PointMark(
                        x: .value(Strings.purchaseDate.localized(), purchase.date),
                        y: .value(Strings.purchaseUnitPrice.localized(), purchase.unitPrice)
                    )
                    .foregroundStyle(.blue)
                    .symbolSize(50)
                }
            }
            .frame(height: 200)
            .chartOverlay { proxy in
                GeometryReader { geometry in
                    Rectangle()
                        .fill(.clear)
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    guard let plotFrame = proxy.plotFrame else { return }
                                    let x = value.location.x - geometry[plotFrame].origin.x
                                    guard x >= 0, x <= geometry[plotFrame].width else { return }

                                    let date = proxy.value(atX: x) as Date?
                                    guard let date = date else { return }

                                    // Find the closest purchase to the tapped point
                                    if let closest = purchases.min(by: {
                                        abs($0.date.timeIntervalSince(date)) < abs($1.date.timeIntervalSince(date))
                                    }) {
                                        selectedPurchase = closest
                                        showPopup = true
                                    }
                                }
                        )
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct PriceHistoryChart_Previews: View {
    @State var selectedPurchase: PurchaseHistory? = nil
    @State var showPopup = false
    var body: some View {
        PriceHistoryChart(
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
            ],
            selectedPurchase: $selectedPurchase,
            showPopup: $showPopup
        )
    }
}

#Preview {
    PriceHistoryChart_Previews()
}
