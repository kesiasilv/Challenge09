//
//  NewsListView.swift
//  Challenge09
//
//  Created by Lizandra Malta on 20/10/25.
//

import SwiftUI

struct NewsListView: View {
    @Environment(NewsViewModel.self) private var vm
    @State private var showingCreate = false
    
    var body: some View {
        NavigationStack {
            Group {
                if vm.isLoading {
                    ProgressView("Carregando...")
                } else if vm.news.isEmpty {
                    ContentUnavailableView("Sem notícias",
                                           systemImage: "newspaper",
                                           description: Text("Toque em + para criar uma notícia."))
                } else {
                    List(vm.news) { item in
                        NavigationLink {
                            NewsDetailView(news: item)
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.title).font(.headline)
                                Text(item.content)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(2)
                            }
                        }
                    }
                    .refreshable { await vm.refresh() }
                }
            }
            .navigationTitle("News")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingCreate = true
                    }
                    label :
                    {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingCreate) {
                CreateNewsView()
            }
            .alert("Erro", isPresented: .constant(vm.lastError != nil)) {
                Button("OK") { vm.lastError = nil }
            } message: {
                Text(vm.lastError ?? "")
            }
        }
    }
}
