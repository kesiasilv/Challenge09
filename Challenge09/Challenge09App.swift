//
//  Challenge09App.swift
//  Challenge09
//
//  Created by Késia Silva Viana on 16/10/25.
//

import SwiftUI
import SwiftData

@main
struct Challenge09App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
		.modelContainer(for: NoticeClass.self)
    }
}
