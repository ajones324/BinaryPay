//
//  ExchangeRates.swift
//  BinariaPay
//
//  Created by Andrew Ikenna Jones on 7/13/23.
//

import Foundation

struct ExchangeRates: Codable {
    let timestamp: Double
    let base: String
    let rates: [String: Double]
    
    func localCurrencyFromBaseWithBinary(base: String = "USD", baseBinary: String, toCurrency: String) -> String? {
        guard base == base else { return nil }
        guard let rate = rates[toCurrency] else { return nil }
        let usd = Int(baseBinary, radix: 2)
        let localCurrency = Double(usd ?? 0) * rate
        return String(Int(localCurrency), radix: 2)
    }
}
