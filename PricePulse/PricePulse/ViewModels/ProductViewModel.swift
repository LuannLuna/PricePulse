//import Foundation
//import Combine
//
//class ProductViewModel: ObservableObject {
//    @Published var products: [String: [Purchase]] = [:]
//    @Published var searchText: String = ""
//    
//    private var cancellables = Set<AnyCancellable>()
//    
//    init() {
//        // Set up search text publisher
//        $searchText
//            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
//            .sink { [weak self] _ in
//                self?.objectWillChange.send()
//            }
//            .store(in: &cancellables)
//    }
//    
//    // MARK: - CSV Processing
//    
//    func processCSVFile(url: URL) {
//        do {
//            let content = try String(contentsOf: url, encoding: .utf8)
//            let rows = content.components(separatedBy: .newlines)
//            
//            // Skip header row
//            let dataRows = Array(rows.dropFirst())
//            
//            for row in dataRows {
//                let columns = row.components(separatedBy: ",")
//                if let purchase = ProductPurchase.fromCSVRow(columns) {
//                    addPurchase(purchase)
//                }
//            }
//        } catch {
//            print("Error processing CSV file: \(error)")
//        }
//    }
//    
//    private func addPurchase(_ purchase: ProductPurchase) {
//        var purchases = products[purchase.productCode] ?? []
//        
//        // Check for duplicate (same product, date, and store)
//        if !purchases.contains(where: { $0.date == purchase.date && $0.store == purchase.store }) {
//            purchases.append(purchase)
//            purchases.sort { $0.date > $1.date } // Sort by date, most recent first
//            products[purchase.productCode] = purchases
//        }
//    }
//    
//    // MARK: - Data Access
//    
//    var filteredProducts: [String: [ProductPurchase]] {
//        guard !searchText.isEmpty else { return products }
//        
//        return products.filter { key, purchases in
//            guard let firstPurchase = purchases.first else { return false }
//            return firstPurchase.productName.localizedCaseInsensitiveContains(searchText)
//        }
//    }
//    
//    func getLastPurchase(for productCode: String) -> ProductPurchase? {
//        return products[productCode]?.first
//    }
//    
//    func getPurchaseHistory(for productCode: String) -> [ProductPurchase] {
//        return products[productCode] ?? []
//    }
//    
//    // MARK: - Price Analysis
//    
//    func calculatePricePerUnit(for purchase: ProductPurchase) -> Double {
//        switch purchase.unit.uppercased() {
//        case "KG":
//            return purchase.unitPrice
//        case "UN":
//            return purchase.unitPrice
//        default:
//            return purchase.unitPrice
//        }
//    }
//    
//    func calculatePriceDifference(for productCode: String) -> Double? {
//        guard let purchases = products[productCode],
//              purchases.count >= 2 else { return nil }
//        
//        let currentPrice = purchases[0].unitPrice
//        let previousPrice = purchases[1].unitPrice
//        
//        return currentPrice - previousPrice
//    }
//} 
