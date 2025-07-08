import Foundation
import SwiftData

class CSVLoader {
    static func loadPurchaseHistory(from url: URL, modelContext: ModelContext) {
        do {
            let csvString = try String(contentsOf: url, encoding: .utf8)
            let rows = csvString.components(separatedBy: .newlines)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy" // Corrigido para o seu formato

            for row in rows.dropFirst() where !row.isEmpty {
                let columns = row.components(separatedBy: ",")
                guard columns.count >= 11 else { continue }

                // Extrair e validar valores
                let idUnico = columns[0]
                let storeName = columns[1]
                let cnpj = columns[2]
                guard let date = dateFormatter.date(from: columns[3]) else { continue }
                let code = columns[4]
                let description = columns[5]
                let quantity = Double(columns[6]) ?? 0
                let unit = columns[7]
                let unitPrice = Double(columns[8]) ?? 0
                let tax = Double(columns[9]) ?? 0
                let total = Double(columns[10]) ?? 0

                // Buscar ou criar Supermercado
                let supermarket = fetchOrCreateSupermarket(cnpj: cnpj, name: storeName, context: modelContext)

                // Buscar ou criar Produto
                let product = fetchOrCreateProduct(code: code, name: description, unit: unit, context: modelContext)

                // Buscar ou criar Purchase (compra do dia)
                let purchase = fetchOrCreatePurchase(date: date, supermarket: supermarket, context: modelContext)

                // Criar PurchaseItem
                let item = PurchaseItem(
                    id: idUnico,
                    quantity: quantity,
                    unitPrice: unitPrice,
                    tax: tax,
                    total: total,
                    product: product,
                    purchase: purchase
                )
                modelContext.insert(item)
            }

            try modelContext.save()
        } catch {
            print("Erro ao carregar CSV: \(error)")
        }
    }

    // MARK: - Helpers

    private static func fetchOrCreateSupermarket(cnpj: String, name: String, context: ModelContext) -> Supermarket {
        let fetchRequest = FetchDescriptor<Supermarket>(
            predicate: #Predicate { $0.cnpj == cnpj }
        )

        if let existing = try? context.fetch(fetchRequest).first {
            return existing
        }

        let newMarket = Supermarket(cnpj: cnpj, name: name)
        context.insert(newMarket)
        return newMarket
    }

    private static func fetchOrCreateProduct(code: String, name: String, unit: String, context: ModelContext) -> Product {
        let fetchRequest = FetchDescriptor<Product>(
            predicate: #Predicate { $0.code == code }
        )

        if let existing = try? context.fetch(fetchRequest).first {
            return existing
        }

        let newProduct = Product(code: code, name: name, unit: unit)
        context.insert(newProduct)
        return newProduct
    }

    private static func fetchOrCreatePurchase(date: Date, supermarket: Supermarket, context: ModelContext) -> Purchase {
        let fetchRequest = FetchDescriptor<Purchase>(
            predicate: #Predicate { $0.date == date }
        )

        if let existing = (try? context.fetch(fetchRequest))?.first(where: { $0.supermarket.cnpj == supermarket.cnpj }) {
            return existing
        }

        let newPurchase = Purchase(date: date, supermarket: supermarket)
        context.insert(newPurchase)
        return newPurchase
    }
}
