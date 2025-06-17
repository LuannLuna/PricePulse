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
