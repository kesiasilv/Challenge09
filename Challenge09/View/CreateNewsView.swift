//
//  CreateNewsView.swift
//  Challenge09
//
//  Created by Lizandra Malta on 20/10/25.
//

import SwiftUI
import CloudKit
import PhotosUI

struct CreateNewsView: View {
    @Environment(NewsViewModel.self) private var vm
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var content = ""

    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var pickedImageData: Data? = nil
    @State private var pickedImageURL: URL? = nil

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

                Section("Imagem (opcional)") {
                    if let data = pickedImageData, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 220)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .overlay {
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .stroke(.quaternary)
                            }
                            .padding(.vertical, 4)
                    } else {
                        Text("Nenhuma imagem selecionada")
                            .foregroundStyle(.secondary)
                    }

                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Label("Escolher foto", systemImage: "photo.on.rectangle")
                    }
                    .onChange(of: selectedItem) { _, newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                pickedImageData = data
                                pickedImageURL = ImageHelper.shared.saveTempImage(data: data)
                            } else {
                                pickedImageData = nil
                                pickedImageURL = nil
                            }
                        }
                    }

                    if pickedImageData != nil {
                        Button(role: .destructive) {
                            pickedImageData = nil
                            pickedImageURL = nil
                        } label: {
                            Label("Remover imagem", systemImage: "trash")
                        }
                    }
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
                            let news = News(
                                id: .init(recordName: UUID().uuidString),
                                title: title.trimmingCharacters(in: .whitespacesAndNewlines),
                                content: content.trimmingCharacters(in: .whitespacesAndNewlines),
                                imageURL: pickedImageURL
                            )

                            await vm.add(news: news)
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
