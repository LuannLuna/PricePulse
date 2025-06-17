import SwiftUI
import SwiftData

struct HomeView: View {
    @Query private var purchases: [PurchaseHistory]
    @State private var searchText = ""
    
    var filteredPurchases: [PurchaseHistory] {
        if searchText.isEmpty {
            return purchases
        }
        return purchases.filter { purchase in
            purchase.itemDescription.localizedCaseInsensitiveContains(searchText) ||
            purchase.productCode.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Search bar
                SearchBar(text: $searchText)
                    .padding()
                
                // Product list
                List {
                    ForEach(filteredPurchases) { purchase in
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
            
            HStack {
                Text("Price: R$\(purchase.unitPrice, specifier: "%.2f")")
                    .font(.subheadline)
                
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
