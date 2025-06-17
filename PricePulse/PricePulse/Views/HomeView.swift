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
                List {
                    ForEach(sortedProducts, id: \.0) { productCode, purchase in
                        NavigationLink(destination: DetailView(purchase: purchase)) {
                            PurchaseRow(purchase: purchase)
                        }
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "search.prompt".localized)
            .navigationTitle("app.title".localized)
        }
    }
}

#Preview {
    HomeView()
}
