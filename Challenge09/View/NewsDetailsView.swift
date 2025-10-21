//
//  NewsDetailsView.swift
//  Challenge09
//
//  Created by Lizandra Malta on 20/10/25.
//

import SwiftUI

struct NewsDetailView: View {
    let news: News
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(news.title)
                    .font(.title).bold()
                    .multilineTextAlignment(.leading)
                if let imageURL = news.imageURL,
                   let uiImage = UIImage(contentsOfFile: imageURL.path) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 240)
                        .clipped()
                        .cornerRadius(12)
                        .padding(.vertical, 8)
                }
                if !news.content.isEmpty {
                    Text(news.content)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
                Text(news.publishedAt?.formatted(date: .abbreviated, time: .shortened) ?? "")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.top, 8)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .navigationTitle("Detalhe")
        .navigationBarTitleDisplayMode(.inline)
    }
}
