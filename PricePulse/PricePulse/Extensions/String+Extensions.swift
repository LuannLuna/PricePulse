//
//  String+Extensions.swift
//  PricePulse
//
//  Created by Luann Luna on 17/06/25.
//

import SwiftUI

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }

    func localized(_ arguments: CVarArg...) -> String {
        String(format: localized, arguments: arguments)
    }
}

extension Text {
    init(_ string: any RawRepresentable<String>) {
        self.init(string.localizable, bundle: .main)
    }
}

extension RawRepresentable where RawValue == String {
    var localizable: LocalizedStringKey {
        .init(rawValue)
    }

    func localized(_ arguments: CVarArg...) -> String {
        rawValue.localized(arguments)
    }
}

extension TextField where Label == Text {
    init(_ titleKey: any RawRepresentable<String>, text: Binding<String>) {
        self.init(titleKey.localizable, text: text)
    }
}
