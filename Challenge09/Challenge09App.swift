//
//  Challenge09App.swift
//  Challenge09
//
//  Created by Késia Silva Viana on 16/10/25.
//

import SwiftUI

@main
struct Challenge09App: App {
    @State private var vm = NewsService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(vm)
        }
    }
}
