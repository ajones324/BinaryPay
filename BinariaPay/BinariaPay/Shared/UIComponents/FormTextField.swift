//
//  FormTextField.swift
//  BinariaPay
//
//  Created by Andrew Ikenna Jones on 7/12/23.
//

import SwiftUI

struct FormTextfield: View {
    @StateObject var viewModel: Self.ViewModel
    @State private var id = UUID()

    var body: some View {
        ScrollViewReader { proxy in
            VStack(alignment: .leading) {
                Text(viewModel.label)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.white)
                    .opacity(viewModel.text.isEmpty ? 0.0 : 1.0)

                ZStack(alignment: .leading) {
                    if viewModel.text.isEmpty {
                        Text(viewModel.label)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.gray)
                    }

                    TextField("", text: $viewModel.text.animation()) { isEditing in
                        if isEditing {
                            withAnimation {
                                proxy.scrollTo(id)
                            }
                        }
                    }
                    .font(.system(size: 16, weight: .bold))
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .foregroundColor(.white)
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)

            }
            .id(id)
        }
    }
}
