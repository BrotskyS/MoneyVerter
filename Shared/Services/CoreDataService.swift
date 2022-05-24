//
//  CoreDataService.swift
//  MoneyVerter (iOS)
//
//  Created by Sergiy Brotsky on 24.05.2022.
//

import SwiftUI
import CoreData

class CoreDataService: ObservableObject {
    @Published var savedCurrency = [CurrencyEntity]()
    
    let container: NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "Currency")
        container.loadPersistentStores{(description, error) in
            if let error = error{
                print("Fail to load core data: \(error)")
            }else{
                print("Success load core data")
            }
        }
        fetchSavedCurrency()
    }
    
    func fetchSavedCurrency(){
        let request = NSFetchRequest<CurrencyEntity>(entityName: "CurrencyEntity")
        
        do{
            savedCurrency =  try container.viewContext.fetch(request)
        }catch let error{
            print("Fail to getch save currency: \(error)")
        }
    }
    
    func addNewCurrency(text: String){
        print("addNewCurrency")
        let newCurrency = CurrencyEntity(context: container.viewContext)
        newCurrency.currencyName = text
        saveCurrency()
    }
    func saveCurrency(){
        do{
            try container.viewContext.save()
            fetchSavedCurrency()
        }catch let error{
            print("Fail to save core data: \(error)")
        }
    }
}

