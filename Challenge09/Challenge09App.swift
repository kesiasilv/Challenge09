//
//  Challenge09App.swift
//  Challenge09
//
//  Created by Késia Silva Viana on 16/10/25.
//

import SwiftUI

@main
struct Challenge09App: App {
    private let push = PushSubscriptionManager()
    private let ckClient = DefaultCloudKitClient()
    
    @State private var vm: NewsViewModel

    init() {
        _vm = State(initialValue: NewsViewModel(repo: CloudKitNewsRepository(ck: ckClient)))
    }
    
    var body: some Scene {
        WindowGroup {
            NewsListView()
                .environment(vm)
                .onAppear {
                    push.requestNotificationPermissions()
                }
        }
    }
}
