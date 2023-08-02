//
//  FormButton.swift
//  BinariaPay
//
//  Created by Andrew Ikenna Jones on 7/13/23.
//

import SwiftUI

struct FormButton: View {
    @Environment(\.isEnabled) private var isEnabled
    @StateObject var viewModel: Self.ViewModel
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            if !isEnabled {
                Text(viewModel.title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48)
                    .background(BPColors.grey800.swiftUIColor)
                    .clipShape(RoundedRectangle(cornerRadius: 35))
            } else {
                switch viewModel.buttonStyle {
                case .normal:
                    Text(viewModel.title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48)
                        .background(BPColors.grey200.swiftUIColor)
                        .clipShape(RoundedRectangle(cornerRadius: 35))
                case .clear:
                    Text(viewModel.title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48)
                        .background(Color.clear)
                        .overlay(RoundedRectangle(cornerRadius: 35)
                            .stroke(.white, lineWidth: 2))
                        .clipShape(RoundedRectangle(cornerRadius: 35))
                case .dark:
                    Text(viewModel.title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48)
                        .background(BPColors.grey900.swiftUIColor)
                        .clipShape(RoundedRectangle(cornerRadius: 35))
                }
            }
        }
    }
}
