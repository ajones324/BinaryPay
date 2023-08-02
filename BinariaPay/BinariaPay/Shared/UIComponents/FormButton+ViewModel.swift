//
//  FormButton+ViewModel.swift
//  BinariaPay
//
//  Created by Andrew Ikenna Jones on 7/13/23.
//

import Combine
import SwiftUI

enum FormButtonStyle {
    case normal
    case clear
    case dark
}

extension FormButton {
    @MainActor class ViewModel: ObservableObject {
        @Published var title: String
        @Published var buttonStyle: FormButtonStyle

        init(title: String, buttonStyle: FormButtonStyle = .normal) {
            self.title = title
            self.buttonStyle = buttonStyle
        }
    }
}
