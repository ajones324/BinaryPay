//
//  SendTransactionsView+ViewModel.swift
//  BinariaPay
//
//  Created by Andrew Ikenna Jones on 7/7/23.
//

import Combine
import SwiftUI

extension SendTransactionsView {
    @MainActor class ViewModel: ObservableObject {
        let firstNameVM = FormTextfield.ViewModel(label: "First Name")
        let lastNameVM = FormTextfield.ViewModel(label: "Last Name")
        let countriesVM = FormDropdownView.ViewModel(label: "Recipient's Country", selections: GlobalConstant.receivingCountryNames)
        let phoneVM = FormTextfield.ViewModel(label: "Phone")
        let dollarToSendVM = FormTextfield.ViewModel(label: "USD(Binary)")
        let receivingCurrencyVM = FormTextfield.ViewModel(label: "Local Currency(Binary)")
        let sendButtonVM = FormButton.ViewModel(title: "Send")
        
        @Published var enableSendButton = false
        @Published var exchangeRates: ExchangeRates?
        @Published var isReadyToNavigate = false
        
        private var cancellableSet: Set<AnyCancellable> = []
        
        private var isFormValid: AnyPublisher<Bool, Never> {
            Publishers.CombineLatest4(
                isNameValid,
                isCountryValid,
                isPhoneValid,
                isCurrencyValid
            )
            .map { $0 && $1 && $2 && $3 }
            .eraseToAnyPublisher()
        }
        
        private var isFirstNameValid: AnyPublisher<Bool, Never> {
            firstNameVM.$text
                .debounce(for: 0.3, scheduler: RunLoop.main)
                .map { $0.isNameValid }
                .eraseToAnyPublisher()
        }
        
        private var isLastNameValid: AnyPublisher<Bool, Never> {
            lastNameVM.$text
                .debounce(for: 0.3, scheduler: RunLoop.main)
                .map { $0.isNameValid }
                .eraseToAnyPublisher()
        }
        
        private var isNameValid: AnyPublisher<Bool, Never> {
            Publishers.CombineLatest(
                isFirstNameValid,
                isLastNameValid
            )
            .map { $0 && $1 }
            .eraseToAnyPublisher()
        }
        
        private var isCountryValid: AnyPublisher<Bool, Never> {
            countriesVM.$text
                .debounce(for: 0.3, scheduler: RunLoop.main)
                .map { GlobalConstant.receivingCountryNames.contains($0) }
                .eraseToAnyPublisher()
        }
        
        private var isPhoneValid: AnyPublisher<Bool, Never> {
            phoneVM.$text
                .debounce(for: 0.3, scheduler: RunLoop.main)
                .map { [weak self] in self?.isPhoneNumberValidByCountry(phoneNumber: $0) ?? false }
                .eraseToAnyPublisher()
        }
        
        private func isPhoneNumberValidByCountry(phoneNumber: String) -> Bool {
            guard let selected = Country(rawValue: countriesVM.text) else { return false}
            let isValidLength = (phoneNumber.count - 4) == selected.numberOfDigitsOfPhoneAfterPrefix
            return (phoneNumber.prefix(4) == selected.phonePrefix) && isValidLength  && phoneNumber.isPhoneNumberValid
        }
        
        private var isCurrencyValid: AnyPublisher<Bool, Never> {
            Publishers.CombineLatest(
                isDollarValid,
                isLocalCurrencyValid
            )
            .map { $0 && $1 }
            .eraseToAnyPublisher()
        }
        
        private var isDollarValid: AnyPublisher<Bool, Never> {
            dollarToSendVM.$text
                .debounce(for: 0.3, scheduler: RunLoop.main)
                .map { $0.isBinaryValid }
                .eraseToAnyPublisher()
        }
        
        private var isLocalCurrencyValid: AnyPublisher<Bool, Never> {
            receivingCurrencyVM.$text
                .debounce(for: 0.3, scheduler: RunLoop.main)
                .map { $0.isBinaryValid }
                .eraseToAnyPublisher()
        }
        
        private func setupFormValidation() {
            isFormValid
                .receive(on: RunLoop.main)
                .assign(to: \.enableSendButton, on: self)
                .store(in: &cancellableSet)
        }
        
        init() {
            setupFormValidation()
            
            countriesVM.$text
                .receive(on: RunLoop.main)
                .sink { [weak self] countryName in
                    guard let selected = Country(rawValue: countryName) else { return }
                    self?.phoneVM.text = selected.phonePrefix
                    self?.receivingCurrencyVM.label = selected.currency + "(Binary)"
                    guard let dollarBinary = self?.dollarToSendVM.text else { return }
                    guard let exchangeRates = self?.exchangeRates else { return }
                    self?.receivingCurrencyVM.text = exchangeRates.localCurrencyFromBaseWithBinary(baseBinary: dollarBinary, toCurrency: selected.currency) ?? ""
                }
                .store(in: &cancellableSet)
            
            dollarToSendVM.$text
                .receive(on: RunLoop.main)
                .sink { [weak self] dollarBinary in
                    guard let countryName = self?.countriesVM.text else { return }
                    guard let selected = Country(rawValue: countryName) else { return }
                    guard let exchangeRates = self?.exchangeRates else { return }
                    self?.receivingCurrencyVM.text = exchangeRates.localCurrencyFromBaseWithBinary(baseBinary: dollarBinary, toCurrency: selected.currency) ?? ""
                }
                .store(in: &cancellableSet)
        }
                
        func updateLatestExchangeRates() {
            Task {
                do {
                    self.exchangeRates = try await ExchangeRatesAPIService.shared.getLatestExchangeRates()
                } catch {
                    print(error)
                }
            }
        }
        
        func didOnAppear() {
            updateLatestExchangeRates()
        }
        
        func didTapSend() {
            isReadyToNavigate = true
        }
    }
}
