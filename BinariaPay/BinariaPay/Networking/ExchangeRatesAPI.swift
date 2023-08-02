//
//  ExchangeRatesAPI.swift
//  BinariaPay
//
//  Created by Andrew Ikenna Jones on 7/13/23.
//

import Combine
import Foundation

enum ExchangeRatesAPIConstants  {
    static let latestRatesAPIEndpoint: String = "https://openexchangerates.org/api/latest.json"
    static let appId: String = "58d121e6fd4545958a8065c35db2c665"
}

protocol ExchangeRatesAPIService_Protocol {
    func getLatestExchangeRates(baseCurrency: String) async throws -> ExchangeRates
}

final class ExchangeRatesAPIService: ExchangeRatesAPIService_Protocol {

    static let shared: ExchangeRatesAPIService = ExchangeRatesAPIService()
    private let jsonDecoder: JSONDecoder
    
    init() {
        self.jsonDecoder = JSONDecoder()
    }
    
    enum ExchangeRatesAPIServiceError: Error {
        case invalidURL
    }
    
    func getLatestExchangeRates(baseCurrency: String = Country.USA.currency) async throws -> ExchangeRates {
        guard let url = URL(string: String(format: "%@?app_id=%@&base=%@", ExchangeRatesAPIConstants.latestRatesAPIEndpoint, ExchangeRatesAPIConstants.appId, baseCurrency)) else {
            throw ExchangeRatesAPIServiceError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)

        return try self.jsonDecoder.decode(ExchangeRates.self, from: data)
    }
}
