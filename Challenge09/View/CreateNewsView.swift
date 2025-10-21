//
//  CreateNewsView.swift
//  Challenge09
//
//  Created by Lizandra Malta on 20/10/25.
//

import SwiftUI
import CloudKit

struct CreateNewsView: View {
    @Environment(NewsViewModel.self) private var vm
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var content = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Título") {
                    TextField("Digite o título", text: $title)
                        .textInputAutocapitalization(.sentences)
                }
                Section("Conteúdo") {
                    TextEditor(text: $content)
                        .frame(minHeight: 150)
                }
            }
            .navigationTitle("Nova notícia")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        Task {
                            await vm.add(
                                news: News(id: .init(recordName: UUID().uuidString), title:  title.trimmingCharacters(in: .whitespacesAndNewlines), content: content.trimmingCharacters(in: .whitespacesAndNewlines)),
                            )
                            dismiss()
                        }
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                              content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}
