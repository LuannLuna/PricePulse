import SwiftUI

struct ProductComparisonView: View {
    @State private var productA = ProductInput()
    @State private var productB = ProductInput()

    var comparisonResult: ComparisonResult? {
        guard
            let valueA = productA.valuePerBaseUnit,
            let valueB = productB.valuePerBaseUnit
        else {
            return nil
        }
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
            Section(header: Text(Strings.comparisonProductA.localizable)) {
                ProductInputView(input: $productA)
            }
            Section(header: Text(Strings.comparisonProductB.localizable)) {
                ProductInputView(input: $productB)
            }
            if let valueA = productA.valuePerBaseUnit, let valueB = productB.valuePerBaseUnit {
                Section(header: Text(Strings.comparisonSection.localizable)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(productA.displayName)
                            Text(Strings.comparisonPerBaseUnit.localized(String(format: "%.2f", valueA), productA.normalizedUnit))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text(productB.displayName)
                            Text(Strings.comparisonPerBaseUnit.localized(String(format: "%.2f", valueB), productB.normalizedUnit))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    Divider()
                    if let result = comparisonResult {
                        switch result {
                        case .aBetter:
                            Text(Strings.comparisonBetterValue.localized(productA.displayName))
                                .foregroundColor(.green)
                        case .bBetter:
                            Text(Strings.comparisonBetterValue.localized(productB.displayName))
                                .foregroundColor(.green)
                        case .equal:
                            Text(Strings.comparisonSameValue.localizable)
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
        .navigationTitle(Strings.comparisonTitle.localizable)
    }
}

// MARK: - ProductInput Struct (Atualizado)

struct ProductInput {
    var name: String = ""
    var unitsPerPackage: String = "" // ex: 12
    var amountPerUnit: String = ""   // ex: 300
    var selectedUnit: Unit = .milliliter
    var price: String = ""           // ex: 10.50

    var unitCount: Double? {
        Double(unitsPerPackage)
    }

    var amount: Double? {
        Double(amountPerUnit)
    }

    var normalizedUnit: String {
        selectedUnit.baseUnit
    }

    var totalNormalizedQuantity: Double? {
        guard
            let unitCount = unitCount,
            let amount = amount
        else {
            return nil
        }
        return selectedUnit.normalize(amount) * unitCount
    }

    var priceValue: Double? {
        Double(price.replacingOccurrences(of: ",", with: "."))
    }

    var valuePerBaseUnit: Double? {
        guard
            let totalAmount = totalNormalizedQuantity,
            let price = priceValue,
            totalAmount > 0
        else {
            return nil
        }
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
        TextField(Strings.comparisonName, text: $input.name)
        TextField(Strings.comparisonUnitsPerPackage, text: $input.unitsPerPackage)
            .keyboardType(.decimalPad)
        TextField(Strings.comparisonAmountPerUnit, text: $input.amountPerUnit)
            .keyboardType(.decimalPad)
        Picker(Strings.comparisonAmountUnit.localizable, selection: $input.selectedUnit) {
            ForEach(Unit.allCases, id: \.self) { unit in
                Text(unit.displayName).tag(unit)
            }
        }
        TextField(Strings.comparisonPrice, text: $input.price)
            .keyboardType(.decimalPad)
    }
}

// MARK: - Enums

enum ComparisonResult {
    case aBetter, bBetter, equal
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
