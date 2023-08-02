//
//  String+Validation.swift
//  BinariaPay
//
//  Created by Andrew Ikenna Jones on 7/13/23.
//

import SwiftUI

extension String {
    
    var isBlank: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var isNumberic: Bool {
        return !(self.isEmpty) && self.allSatisfy { $0.isNumber }
    }

    private func isStringLengthValid(range: ClosedRange<Int>) -> Bool {
        range.contains(count)
    }

    /// Match first occurrence of `rhs` in `lhs`.
    static func &= (lhs: String, rhs: CharacterSet) -> Bool {
        return lhs.rangeOfCharacter(from: rhs) != nil
    }
    
    var isNameValid: Bool {
        var characters = CharacterSet()
        characters.formUnion(.uppercaseLetters)
        characters.formUnion(.lowercaseLetters)
        characters.formUnion(.whitespaces)
        characters.invert()
        
        return !(self &= characters) && !isBlank
    }
    
    var isBinaryValid: Bool {
        var result = true
        for c in self {
            result = result && ( c == "0" || c == "1")
        }
        return result && !isBlank
    }
    
    var isPhoneNumberValid: Bool {
        return self.replacingOccurrences(of: "+", with: "").replacingOccurrences(of: " ", with: "").isNumberic
    }
}

