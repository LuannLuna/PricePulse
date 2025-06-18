import SwiftUI

enum NavigationDestination: Hashable {
    case home
    case detailView(PurchaseHistory)
    case productDetail(String)
    case purchaseHistory(String)
    case settings
    // Add more destinations as needed
}

@Observable
final class Router {
    var navigationPath = NavigationPath()
    var presentedSheet: NavigationDestination?
    var presentedFullScreenCover: NavigationDestination?
    
    func push(_ destination: NavigationDestination) {
        navigationPath.append(destination)
    }
    
    func presentSheet(_ destination: NavigationDestination) {
        presentedSheet = destination
    }
    
    func presentFullScreenCover(_ destination: NavigationDestination) {
        presentedFullScreenCover = destination
    }
    
    func dismissSheet() {
        presentedSheet = nil
    }
    
    func dismissFullScreenCover() {
        presentedFullScreenCover = nil
    }
    
    func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
    
    func pop() {
        navigationPath.removeLast()
    }
}

struct RouterView<Content: View>: View {
    @State private var router = Router()
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            content
                .navigationDestination(for: NavigationDestination.self) { destination in
                    destinationView(for: destination)
                }
                .sheet(item: $router.presentedSheet) { destination in
                    destinationView(for: destination)
                }
                .fullScreenCover(item: $router.presentedFullScreenCover) { destination in
                    destinationView(for: destination)
                }
        }
        .environment(router)
    }
    
    @ViewBuilder
    private func destinationView(for destination: NavigationDestination) -> some View {
        switch destination {
            case .home:
                HomeView()

            case let .detailView(purchase):
                DetailView(purchase: purchase)

            case .productDetail(let id):
                Text("Product Detail: \(id)") // Replace with your actual ProductDetailView

            case .purchaseHistory(let id):
                Text("Purchase History: \(id)") // Replace with your actual PurchaseHistoryView

            case .settings:
                Text("Settings") // Replace with your actual SettingsView
        }
    }
}

// Extension to make NavigationDestination conform to Identifiable for sheet presentation
extension NavigationDestination: Identifiable {
    var id: Self { self }
} 
