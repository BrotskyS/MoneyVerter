//
//  ContentView.swift
//  Shared
//
//  Created by Sergiy Brotsky on 24.05.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var coreModel = CoreDataService()
    var body: some View {
        HomeView()
            .environmentObject(coreModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
