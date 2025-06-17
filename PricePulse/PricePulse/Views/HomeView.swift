import SwiftUI
import SwiftData

struct HomeView: View {
    @Query private var purchases: [PurchaseHistory]
    @State private var searchText = ""
    
    var groupedPurchases: [String: PurchaseHistory] {
        let filtered = searchText.isEmpty ? purchases : purchases.filter { purchase in
            purchase.itemDescription.localizedCaseInsensitiveContains(searchText) ||
            purchase.productCode.localizedCaseInsensitiveContains(searchText)
        }
        
        // Group by product code and get the most recent purchase for each
        return Dictionary(grouping: filtered) { $0.productCode }
            .mapValues { purchases in
                purchases.sorted { $0.date > $1.date }.first!
            }
    }
    
    var sortedProducts: [(String, PurchaseHistory)] {
        groupedPurchases.sorted { $0.value.date > $1.value.date }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Search bar
                SearchBar(text: $searchText)
                    .padding()
                
                // Product list
                List {
                    ForEach(sortedProducts, id: \.0) { productCode, purchase in
                        NavigationLink(destination: DetailView(purchase: purchase)) {
                            PurchaseRow(purchase: purchase)
                        }
                    }
                }
            }
            .navigationTitle("Price Pulse")
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search products...", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct PurchaseRow: View {
    let purchase: PurchaseHistory
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(purchase.itemDescription)
                .font(.headline)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
            
            HStack {
                Text("Price: R$\(purchase.unitPrice, specifier: "%.2f")")
                    .font(.subheadline)
                    .bold()
                
                Spacer()
                
                Text(purchase.store)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Text("Date: \(purchase.date, style: .date)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("Qty: \(purchase.quantity, specifier: "%.1f") \(purchase.unit)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    HomeView()
}
