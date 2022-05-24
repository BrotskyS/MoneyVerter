//
//  ListViewModel.swift
//  MoneyVerter (iOS)
//
//  Created by Sergiy Brotsky on 24.05.2022.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var showModal = false
    @Published var currencies = [String: Double]()
    @Published var selectedCurrency = "UAH"
    @Published var priceNumber = ""
    
    
    private var currencyService = CurrencyService()
    
    init(){
        currencyService.getFavoritesCurrency { result in
            self.currencies = result.results
        }
    }
    
    func realPriceCurrency(currency: String) -> Double{
            let currencyNumber: Double? = Double(priceNumber) ?? 0
        if(selectedCurrency == "USD"){
            return currencyNumber! * (currencies[currency] ?? 0)
        }else{
            let convertToUSD =   (Double(priceNumber) ?? 0) /  (currencies[selectedCurrency] ?? 0 )
            return convertToUSD * (currencies[currency] ?? 0)
        }
    
    }
    
}
