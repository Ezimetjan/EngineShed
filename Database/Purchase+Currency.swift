//
//  Purchase+Currency.swift
//  EngineShed
//
//  Created by Scott James Remnant on 3/2/19.
//  Copyright © 2019 Scott James Remnant. All rights reserved.
//

import Foundation

extension Purchase {

    /// Formatter for currency types.
    public var currencyFormatter: NumberFormatter {
        let locale = Locale(identifier: "en_GB")

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        formatter.generatesDecimalNumbers = true
        return formatter
    }

    /// `price` formatted as string using `currencyFormatter`.
    public var priceAsString: String? {
        return price.flatMap {
            currencyFormatter.string(from: $0)
        }
    }

    /// `valuation` formatted as string using `currencyFormatter`.
    public var valuationAsString: String? {
        return valuation.flatMap {
            currencyFormatter.string(from: $0)
        }
    }

}
