//
//  BinariaPayApp.swift
//  BinariaPay
//
//  Created by Andrew Ikenna Jones on 7/7/23.
//

import SwiftUI

@main
struct BinariaPayApp: App {
    var body: some Scene {
        WindowGroup {
            SendTransactionsView(viewModel: SendTransactionsView.ViewModel())
        }
    }
}
