//
//  NewsModel.swift
//  Challenge09
//
//  Created by Lizandra Malta on 20/10/25.
//

import CloudKit

struct News: Identifiable, Hashable {
    let id: CKRecord.ID
    var title: String
    var content: String
    var imageURL: URL?
    var publishedAt: Date?
}

extension News {
    init?(record: CKRecord) {
        guard
            let title = record["title"] as? String,
            let content = record["content"] as? String
        else { return nil }
        
        self.id = record.recordID
        self.title = title
        self.content = content
        self.imageURL = (record["image"] as? CKAsset)?.fileURL
        self.publishedAt = record.creationDate
    }
    
    func toRecord() -> CKRecord {
        let record = CKRecord(recordType: "News", recordID: id)
        record["title"] = title as String
        record["content"] = content as String
        if let imageURL {
            record["image"] = CKAsset(fileURL: imageURL)
        }
        return record
    }
}
