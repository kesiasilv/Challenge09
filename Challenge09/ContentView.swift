//
//  ContentView.swift
//  Challenge09
//
//  Created by Késia Silva Viana on 16/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var vm = CloudKitViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
