//
//  ListView.swift
//  MoneyVerter (iOS)
//
//  Created by Sergiy Brotsky on 24.05.2022.
//

import SwiftUI

enum FocusField: Hashable {
  case field
}

struct HomeView: View {
    @ObservedObject var model = HomeViewModel()
    @EnvironmentObject var coreModel: CoreDataService
    @FocusState private var focusedField: FocusField?
    @State var text = ""
    var body: some View {
        NavigationView{
            Form{
                Section{
                    HStack{
                        Text("Ukraine")
                        Spacer()
                        Text("200")
                    }
                }
                ForEach(coreModel.savedCurrency){ item in
                    if let currencyName = item.currencyName{
                        HStack{
                            Text(currencyName)
                            Spacer()
                            if model.selectedCurrency == currencyName{
                                TextField("0", text: $model.priceNumber)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                                    .focused($focusedField, equals: .field)
                                    .task {
                                            self.focusedField = .field
                                        }
                                    
                            }else{
                                Text(String(format: "%.3f",model.realPriceCurrency(currency: currencyName)))
                            }
                            
                      
                        }
                        .onTapGesture {
                            model.selectedCurrency = currencyName ?? ""
                        }
                    }
              
                }
                .onDelete(perform: delete)
                .onMove { IndexSet, Int in
                    
                }
                
            }
            .sheet(isPresented: $model.showModal, content: {
                AllCurrencyView()
            })
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button{
                    model.showModal = true
                } label: {
                    Text("Add")
                }
            )
            .navigationTitle("Money Vertor")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    func delete(at offsets: IndexSet) {
        //        users.remove(atOffsets: offsets)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(CoreDataService())
    }
}
