//
//  CurrencyService.swift
//  MoneyVerter (iOS)
//
//  Created by Sergiy Brotsky on 24.05.2022.
//

import SwiftUI

class CurrencyService: ObservableObject{
    private var API = "https://api.fastforex.io"
    private var token = "39a1cdb32c-112ccbed6e-rce112"
    
    
    func getFavoritesCurrency(completion: @escaping(CurrencyResult) -> Void){
        guard let url = URL(string: API + "/fetch-all?from=USD&api_key=" + token ) else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedUsers = try JSONDecoder().decode(CurrencyResult.self, from: data)
                        completion(decodedUsers)
    
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
    }
    
    func getAllCurrency(completion: @escaping(AllCurrency) -> Void){
        guard let url = URL(string: API + "/currencies" + "?api_key=" + token ) else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return print("Error responce") }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedUsers = try JSONDecoder().decode(AllCurrency.self, from: data)
                        print("decodedUsers\(decodedUsers.ms)")
                        completion(decodedUsers)
    
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }else{
                print("response.statusCode\(response.statusCode)")
            }
        }

        dataTask.resume()
    }
}
