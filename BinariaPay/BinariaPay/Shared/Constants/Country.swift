//
//  Country.swift
//  BinariaPay
//
//  Created by Andrew Ikenna Jones on 7/12/23.
//

import Foundation

enum Country: String, CaseIterable {
    case USA = "United Sates", Kenya = "Kenya", Nigeria = "Nigeria", Tanzania = "Tanzania", Uganda = "Uganda"
    
    var currency: String {
        switch self {

        case .Kenya:
            return "KES"
        case .Nigeria:
            return "NGN"
        case .Tanzania:
            return "TZS"
        case .Uganda:
            return "UGX"
        case .USA:
            return "USD"
        }
    }
    
    var phonePrefix: String {
        switch self {
            
        case .Kenya:
            return "+254"
        case .Nigeria:
            return "+234"
        case .Tanzania:
            return "+255"
        case .Uganda:
            return "+256"
        case .USA:
            return "+1"
        }
    }
    
    var numberOfDigitsOfPhoneAfterPrefix: Int {
        switch self {
            
        case .Kenya:
            return 9
        case .Nigeria:
            return 7
        case .Tanzania:
            return 9
        case .Uganda:
            return 7
        case .USA:
            return 10
        }
    }
}
