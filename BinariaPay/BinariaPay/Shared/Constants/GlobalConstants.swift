//
//  GlobalConstants.swift
//  BinariaPay
//
//  Created by Andrew Ikenna Jones on 7/12/23.
//

import SwiftUI

enum GlobalConstant {
    static let receivingCountries = [Country.Kenya, Country.Nigeria, Country.Tanzania, Country.Uganda]
    static let receivingCountryNames = receivingCountries.map{ $0.rawValue }
}
