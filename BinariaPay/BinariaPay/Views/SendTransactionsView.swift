//
//  ContentView.swift
//  BinariaPay
//
//  Created by Andrew Ikenna Jones on 7/7/23.
//

import SwiftUI

struct SendTransactionsView: View {
    @StateObject var viewModel: Self.ViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text("Send Transactions")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 14)
                    .padding(.leading, 24)
                    .padding(.bottom, 12)
                    .padding(.top, 24)
                    .font(.system(size: 20, weight: .bold))
                
                VStack(alignment: .leading, spacing: 24) {
                    FormTextfield(viewModel: viewModel.firstNameVM)
                    FormTextfield(viewModel: viewModel.lastNameVM)
                    FormDropdownView(viewModel: viewModel.countriesVM)
                    FormTextfield(viewModel: viewModel.phoneVM)
                        .keyboardType(.numbersAndPunctuation)
                    FormTextfield(viewModel: viewModel.dollarToSendVM)
                        .keyboardType(.numbersAndPunctuation)
                    FormTextfield(viewModel: viewModel.receivingCurrencyVM)
                        .keyboardType(.numbersAndPunctuation)
                        .disabled(true)
                    
                    FormButton(viewModel: viewModel.sendButtonVM) {
                        viewModel.didTapSend()
                    }
                    .disabled(!viewModel.enableSendButton)
                    .padding(.top, 50)
                    
                    
                    NavigationLink(isActive: $viewModel.isReadyToNavigate) {
                        TransactionSuccessView()
                    } label: {
                        EmptyView()
                    }
                }
                .padding([.leading, .trailing], 24)
            }
            .background(BPColors.grey1000.swiftUIColor.edgesIgnoringSafeArea(.all))
            .foregroundColor(.white)
            .onAppear {
                viewModel.didOnAppear()
                
            }
        }
    }
}
