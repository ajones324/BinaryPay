//
//  FormTextField+ViewModel.swift
//  BinariaPay
//
//  Created by Andrew Ikenna Jones on 7/12/23.
//

import Combine
import SwiftUI

extension FormTextfield {
    @MainActor class ViewModel: ObservableObject {
        @Published var text = ""
        @Published var label: String

        init(label: String) {
            self.label = label
        }
    }
}
