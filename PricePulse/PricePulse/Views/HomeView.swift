import SwiftUI
import SwiftData

struct HomeView: View {
    @Query private var purchaseItems: [PurchaseItem]
    @State private var searchText = ""
    @Environment(Router.self) private var router
    
    // Group by product code, get most recent purchase per product
    var groupedPurchases: [String: PurchaseItem] {
        // Filter first
        let filtered = searchText.isEmpty
            ? purchaseItems
            : purchaseItems.filter { item in
                item.product.name.localizedCaseInsensitiveContains(searchText) ||
                item.product.code.localizedCaseInsensitiveContains(searchText)
            }

        // Group by product code, keeping only the most recent PurchaseItem for each product
        var result: [String: PurchaseItem] = [:]
        for item in filtered {
            let code = item.product.code
            if let existing = result[code] {
                // Keep the one with the latest purchase date
                if item.purchase.date > existing.purchase.date {
                    result[code] = item
                }
            } else {
                result[code] = item
            }
        }
        return result
    }

    var sortedProducts: [(String, PurchaseItem)] {
        groupedPurchases.sorted { $0.value.purchase.date > $1.value.purchase.date }
    }

    var body: some View {
        VStack {
            List {
                ForEach(Array(sortedProducts.enumerated()), id: \ .offset) { idx, element in
                    let (productCode, purchase) = element
                    let productPurchases = purchaseItems.filter { $0.product.code == productCode }.sorted { $0.purchase.date > $1.purchase.date }
                    let previousPurchase = productPurchases.count > 1 ? productPurchases[1] : nil
                    PurchaseRow(purchase: purchase, previousPurchase: previousPurchase)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            router.push(.detailView(purchase))
                        }
                }
            }
            .listStyle(.sidebar)
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer,
            prompt: Strings.searchPrompt.localized()
        )
        .navigationTitle(Strings.appTitle.localized())
    }
}

#if DEBUG
struct HomeView_Previews: View {
    @State private var router = Router()
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            HomeView()
                .environment(router)
                .modelContainer(Previews.modelContainer)
        }
    }
}

#Preview {
    HomeView_Previews()
}
#endif
