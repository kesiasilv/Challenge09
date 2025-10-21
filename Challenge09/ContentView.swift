//
//  ContentView.swift
//  Challenge09
//
//  Created by Késia Silva Viana on 16/10/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(NewsService.self) var vm
    private var notificationService = NotificationService()
    
    var body: some View {
        VStack {
            if(vm.isFetchingNews) {
                ProgressView()
            }else {
                List(vm.news){ item in
                    Text(item.title)
                }
            }
        }
        .padding()
        .onAppear {
            notificationService.requestNotificationPermissions()
        }
    }
}

#Preview {
    ContentView()
}
