//
//  Unit.swift
//  PricePulse
//
//  Created by Luann Luna on 07/07/25.
//

// MARK: - Unit Enum
enum Unit: String, CaseIterable {
    case milliliter = "ml"
    case liter = "l"
    case gram = "g"
    case kilogram = "kg"
    case meter = "m"
    case unit = "un"

    var displayName: any RawRepresentable<String> {
        switch self {
            case .milliliter: Strings.comparisonDisplayMilliliter
            case .liter: Strings.comparisonDisplayLiter
            case .gram: Strings.comparisonDisplayGram
            case .kilogram: Strings.comparisonDisplayKilogram
            case .meter: Strings.comparisonDisplayMeter
            case .unit: Strings.comparisonDisplayUnit
        }
    }

    var baseUnit: String {
        switch self {
        case .milliliter, .liter: return "L"
        case .gram, .kilogram: return "kg"
        case .meter: return "m"
        case .unit: return "un"
        }
    }

    func normalize(_ value: Double) -> Double {
        switch self {
        case .milliliter: return value / 1000.0
        case .liter: return value
        case .gram: return value / 1000.0
        case .kilogram: return value
        case .meter: return value
        case .unit: return value
        }
    }
}
