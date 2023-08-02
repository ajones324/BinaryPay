//
//  FormDropDownView+ViewModel.swift
//  BinariaPay
//
//  Created by Andrew Ikenna Jones on 7/12/23.
//

import Combine
import SwiftUI

extension FormDropdownView {
    @MainActor class ViewModel: ObservableObject {
        @Published var text: String
        @Published var selections: [String]
        @Published var label: String
        @Published var isExpanded = false

        init(label: String, selections: [String]) {
            self.label = label
            text = label
            var cancellableSelections = selections
            cancellableSelections.insert("", at: 0)
            self.selections = cancellableSelections
            isExpanded = isExpanded
        }
    }
}
