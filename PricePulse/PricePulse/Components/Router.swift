import SwiftUI

enum TabDestination: Hashable {
    case home
    case statistics
}

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
    var selectedTab: TabDestination = .home
    
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
    
    func selectTab(_ tab: TabDestination) {
        selectedTab = tab
    }
}

struct RouterView: View {
    @State private var router = Router()
    
    var body: some View {
        TabView(selection: $router.selectedTab) {
            NavigationStack(path: $router.navigationPath) {
                HomeView()
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
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(TabDestination.home)
            
            NavigationStack {
                StatisticsView()
            }
            .tabItem {
                Label(Strings.statistics.localizable, systemImage: "chart.bar.fill")
            }
            .tag(TabDestination.statistics)
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
