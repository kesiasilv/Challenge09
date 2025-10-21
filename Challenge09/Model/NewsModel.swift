//
//  NewsModel.swift
//  Challenge09
//
//  Created by Lizandra Malta on 20/10/25.
//

import Foundation
import CloudKit

struct NewsModel: Identifiable {
    let id: UUID
    let title: String
    let content: String
    
    init(title: String, date: Date, content: String) {
        self.id = UUID()
        self.title = title
        self.content = content
    }
    
    init(record: CKRecord) {
        self.id = UUID()
        self.title = record["title"] as? String ?? ""
        self.content = record["content"] as? String ?? ""
    }
}
