import SwiftUI
import Charts
import SwiftData

struct DetailView: View {
    let purchase: PurchaseHistory
    @Query private var allPurchases: [PurchaseHistory]
    
    var productPurchases: [PurchaseHistory] {
        allPurchases.filter { $0.productCode == purchase.productCode }
            .sorted { $0.date > $1.date }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(purchase.itemDescription)
                    .font(.headline)
                    .lineLimit(0)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.leading)
                // Last Purchase Summary
                LastPurchaseSummary(purchase: purchase)
                
                // Price History Chart
                PriceHistoryChart(purchases: productPurchases)
                
                // Purchase History Table
                PurchaseHistoryTable(purchases: productPurchases)
            }
            .padding()
        }
    }
}

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

struct PurchaseHistoryTable: View {
    let purchases: [PurchaseHistory]
    
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
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                    
                    HStack {
                        Text("R$\(purchase.unitPrice, specifier: "%.2f")")
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
