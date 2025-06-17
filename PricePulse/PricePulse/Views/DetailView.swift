import SwiftUI
import Charts

struct DetailView: View {
    let productCode: String
    @ObservedObject var viewModel: ProductViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let lastPurchase = viewModel.getLastPurchase(for: productCode) {
                    // Last Purchase Summary
                    LastPurchaseSummary(purchase: lastPurchase)
                    
                    // Price History Chart
                    PriceHistoryChart(purchases: viewModel.getPurchaseHistory(for: productCode))
                    
                    // Purchase History Table
                    PurchaseHistoryTable(purchases: viewModel.getPurchaseHistory(for: productCode))
                }
            }
            .padding()
        }
        .navigationTitle(viewModel.getLastPurchase(for: productCode)?.productName ?? "Product Details")
    }
}

struct LastPurchaseSummary: View {
    let purchase: ProductPurchase
    
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
                    Text("$\(purchase.unitPrice, specifier: "%.2f")")
                }
                GridRow {
                    Text("Quantity:")
                    Text("\(purchase.quantity, specifier: "%.1f") \(purchase.unit)")
                }
                GridRow {
                    Text("Total Price:")
                    Text("$\(purchase.totalPrice, specifier: "%.2f")")
                }
                GridRow {
                    Text("Tax:")
                    Text("$\(purchase.tax, specifier: "%.2f")")
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct PriceHistoryChart: View {
    let purchases: [ProductPurchase]
    
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

struct PurchaseHistoryTable: View {
    let purchases: [ProductPurchase]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Purchase History")
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
                    }
                    
                    HStack {
                        Text("$\(purchase.unitPrice, specifier: "%.2f")")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text("\(purchase.quantity, specifier: "%.1f") \(purchase.unit)")
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