//
//  SelectedCurrencyRow.swift
//  MoneyVerter (iOS)
//
//  Created by Sergiy Brotsky on 24.05.2022.
//

import SwiftUI

struct SelectedCurrencyRow: View {
    var title: String
    @Binding var text: String{
        didSet{
            realText = text
        }
    }
    @State var realText = ""
    
    var body: some View {
        HStack{
            Text(title)
            
            TextField("0", text: $text)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.trailing)
        }
    }
}

struct SelectedCurrencyRow_Previews: PreviewProvider {
    static var previews: some View {
        SelectedCurrencyRow(title: "USD", text: .constant(""))
    }
}
