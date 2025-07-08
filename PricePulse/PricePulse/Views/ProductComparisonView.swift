import SwiftUI

struct ProductComparisonView: View {
    @State private var productA = ProductInput()
    @State private var productB = ProductInput()

    var comparisonResult: ComparisonResult? {
        guard let valueA = productA.valuePerBaseUnit, let valueB = productB.valuePerBaseUnit else { return nil }
        if valueA < valueB {
            return .aBetter
        } else if valueB < valueA {
            return .bBetter
        } else {
            return .equal
        }
    }

    var body: some View {
        Form {
            Section(header: Text("Product A")) {
                ProductInputView(input: $productA)
            }
            Section(header: Text("Product B")) {
                ProductInputView(input: $productB)
            }
            if let valueA = productA.valuePerBaseUnit, let valueB = productB.valuePerBaseUnit {
                Section(header: Text("Comparison")) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(productA.displayName)
                            Text("R$\(valueA, specifier: "%.2f") per \(productA.normalizedUnit)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text(productB.displayName)
                            Text("R$\(valueB, specifier: "%.2f") per \(productB.normalizedUnit)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    Divider()
                    if let result = comparisonResult {
                        switch result {
                        case .aBetter:
                            Text("\(productA.displayName) gives better value for money.")
                                .foregroundColor(.green)
                        case .bBetter:
                            Text("\(productB.displayName) gives better value for money.")
                                .foregroundColor(.green)
                        case .equal:
                            Text("Both products offer the same value for money.")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
        .navigationTitle("Compare Products")
    }
}

// MARK: - ProductInput Struct (Atualizado)

struct ProductInput {
    var name: String = ""
    var unitsPerPackage: String = "" // ex: 12
    var amountPerUnit: String = ""   // ex: 300
    var amountUnit: String = ""      // ex: ml
    var price: String = ""           // ex: 10.50

    var unitCount: Double? {
        Double(unitsPerPackage)
    }

    var amount: Double? {
        Double(amountPerUnit)
    }

    var normalizedUnit: String {
        UnitNormalizer.baseUnit(for: amountUnit)
    }

    var totalNormalizedQuantity: Double? {
        guard let unitCount = unitCount, let amount = amount else { return nil }
        return UnitNormalizer.normalize(amount, from: amountUnit).map { $0 * unitCount }
    }

    var priceValue: Double? {
        Double(price.replacingOccurrences(of: ",", with: "."))
    }

    var valuePerBaseUnit: Double? {
        guard let totalAmount = totalNormalizedQuantity, let price = priceValue, totalAmount > 0 else { return nil }
        return price / totalAmount
    }

    var displayName: String {
        if name.isEmpty { return "Product" }
        return name
    }
}

// MARK: - ProductInputView (Atualizado)

struct ProductInputView: View {
    @Binding var input: ProductInput
    var body: some View {
        TextField("Name", text: $input.name)
        TextField("Units per package", text: $input.unitsPerPackage)
            .keyboardType(.decimalPad)
        TextField("Amount per unit (e.g. 300)", text: $input.amountPerUnit)
            .keyboardType(.decimalPad)
        TextField("Amount unit (e.g. ml, g, m)", text: $input.amountUnit)
        TextField("Price (R$)", text: $input.price)
            .keyboardType(.decimalPad)
    }
}

// MARK: - Normalizer and Enums

enum ComparisonResult {
    case aBetter, bBetter, equal
}

struct UnitNormalizer {
    static func baseUnit(for unit: String) -> String {
        let u = unit.lowercased().trimmingCharacters(in: .whitespaces)
        switch u {
        case "ml", "l": return "L"
        case "g", "kg": return "kg"
        case "m": return "m"
        case "un": return "un"
        default: return u
        }
    }

    static func normalize(_ value: Double, from unit: String) -> Double? {
        let u = unit.lowercased().trimmingCharacters(in: .whitespaces)
        switch u {
        case "ml": return value / 1000.0
        case "l": return value
        case "g": return value / 1000.0
        case "kg": return value
        case "m": return value
        case "un": return value
        default: return value
        }
    }
}

#if DEBUG
struct ProductComparisonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductComparisonView()
        }
    }
}
#endif // DEBUG
