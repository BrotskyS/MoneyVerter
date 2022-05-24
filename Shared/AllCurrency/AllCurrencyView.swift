//
//  AllCurrencyView.swift
//  MoneyVerter (iOS)
//
//  Created by Sergiy Brotsky on 24.05.2022.
//

import SwiftUI

struct AllCurrencyView: View {
    @ObservedObject var model = AllCurrencyViewModel()
    @EnvironmentObject var coreModel: CoreDataService
    var body: some View {
        NavigationView {
            List{
                ForEach(model.searchResults.sorted(by: >), id: \.key) { key, value in
                    CurrencyRowView(currencyKey: key, currencyTitle: value, selectedItem: $model.selectedItems) { key in
                        print("try save")
                        coreModel.addNewCurrency(text: key)
                        
                    }
                }

                
            }
            .searchable(text: $model.searchText)
            .navigationTitle("Select new currencies")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct AllCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        AllCurrencyView()
            .environmentObject(CoreDataService())
    }
}
