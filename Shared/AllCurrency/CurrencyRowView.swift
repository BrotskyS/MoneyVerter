//
//  CountryRowView.swift
//  MoneyVerter (iOS)
//
//  Created by Sergiy Brotsky on 24.05.2022.
//

import SwiftUI

struct CurrencyRowView: View {
    typealias Action = (String) -> Void
    let currencyKey: String
    let currencyTitle: String
    @Binding var selectedItem: [String]
    var action: Action?
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(currencyKey)
                Text(currencyTitle)
                    .font(.caption)
                    .foregroundColor(.gray.opacity(0.6))
            }
            Spacer()
            if selectedItem.contains(currencyKey){
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if selectedItem.contains(currencyKey){
               
                self.selectedItem = self.selectedItem.filter(){$0 != currencyKey}
                
            }else{
                self.selectedItem.append(currencyKey)
            }
            if let action = action{
                action(currencyKey)
            }
            
        }
    }
}

struct CurrencyRowView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRowView(currencyKey: "USD", currencyTitle: "USD dolar", selectedItem: .constant(["USD"]))
    }
}
