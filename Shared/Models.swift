//
//  Models.swift
//  MoneyVerter (iOS)
//
//  Created by Sergiy Brotsky on 24.05.2022.
//

import SwiftUI
import Foundation

struct Country: Hashable, Decodable{
    var name: String
    var dial_code: String
    var code: String
    var flag: String
}

struct CurrencyResult: Codable {
    let base: String
    let results: [String: Double]
    let updated: String
    let ms: Int
}

struct AllCurrency: Codable{
    let currencies: [String: String]
    let ms: Int
}

var coutries: [Country] = load("countries.json")


func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}



