//
//  AllCurrencyViewModel.swift
//  MoneyVerter (iOS)
//
//  Created by Sergiy Brotsky on 24.05.2022.
//

import SwiftUI

class AllCurrencyViewModel: ObservableObject{
    
    @Published var allCurrency = [String: String]()
    @Published var selectedItems:[String] = []
    @Published var searchText = ""
    
    private var currencyService = CurrencyService()
    
    var searchResults: [String: String] {
        if searchText.isEmpty {
            return allCurrency
        } else {
            return  allCurrency.filter { $0.key.contains(searchText) || $0.value.contains(searchText) }
        }
    }
    
    init(){
        currencyService.getAllCurrency { result in
            self.allCurrency = result.currencies
        }
    }
}
