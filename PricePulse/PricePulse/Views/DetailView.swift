import SwiftUI
import Charts
import SwiftData

struct DetailView: View {
    let purchase: PurchaseItem
    @Query private var allPurchases: [PurchaseItem]
    @State private var selectedPurchase: PurchaseItem?
    @State private var showPopup = false
    
    var productPurchases: [PurchaseItem] {
        allPurchases.filter { $0.product.code  == purchase.product.code }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(purchase.product.name)
                    .font(.headline)
                    .lineLimit(0)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.leading)
                
                // Last Purchase Summary
                LastPurchaseSummary(purchase: purchase)
                
                // Price History Chart
                PriceHistoryChart(purchases: productPurchases, selectedPurchase: $selectedPurchase, showPopup: $showPopup)
                
                // Purchase History Table
                PurchaseHistoryTable(purchases: productPurchases)
            }
            .padding()
        }
        .overlay {
            if showPopup, let selected = selectedPurchase {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showPopup = false
                    }
                
                VStack(spacing: 12) {
                    Text(String(format: "price.history.popup.price".localized, 
                              String(format: "currency.format".localized, selected.unitPrice)))
                        .font(.headline)
                    
                    Text(String(format: "price.history.popup.date".localized, 
                                selected.purchase.date.formatted(date: .long, time: .omitted)))
                        .font(.subheadline)
                    
                    Text(String(format: "price.history.popup.store".localized, selected.purchase.supermarket.name))
                        .font(.subheadline)
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .shadow(radius: 5)
                .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.spring(), value: showPopup)
    }
}
