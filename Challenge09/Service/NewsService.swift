//
//  Untitled.swift
//  Challenge09
//
//  Created by Lizandra Malta on 17/10/25.
//

import Foundation
import CloudKit

@Observable
class NewsService {
    var news: [NewsModel] = []
    var isFetchingNews: Bool = false
    
    init(){
        fetchNews()
    }
    
    func getStatus() async -> CloudKitStatus {
        do {
            let status = try await CKContainer.default().accountStatus()
            
            switch status {
            case .available:
                return .OK
            case .couldNotDetermine:
                return .iCloudAccountNotDeterminate
            case .noAccount:
                return .iCloudAccountNotFound
            case .restricted:
                return .iCloudAccountRestricted
            case .temporarilyUnavailable:
                return .iCloudAccountUnknown
            default:
                return .iCloudAccountUnknown
            }
        } catch {
            print("❌ Erro ao recuperar status:", error.localizedDescription)
            return .iCloudAccountUnknown
        }
    }
    
    func addNews(news: NewsModel) {
        let newRecord = CKRecord(recordType: "News")
        newRecord["title"] = news.title
        newRecord["content"] = news.content
        
        Task {
            await saveNews(record: newRecord)
        }
    }
    
    func saveNews(record: CKRecord) async {
        let iCloudStatus = await getStatus()
        
        print("CloudKit Status:", iCloudStatus)
        
        guard iCloudStatus == .OK else {
            print("⚠️ iCloud não disponível.")
            return
        }
        
        do {
            let savedRecord = try await CKContainer.default().publicCloudDatabase.save(record)
            print("✅ Record salvo:", savedRecord)
            await MainActor.run { self.fetchNews() }
        } catch {
            print("❌ Erro ao salvar record:", error.localizedDescription)
        }
    }
    
    func fetchNews() {
        Task { @MainActor in
            self.isFetchingNews = true
        }
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "News", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        var items: [NewsModel] = []
        
        queryOperation.recordMatchedBlock = { (_, result) in
            switch result {
            case .success(let record):
                items.append(NewsModel(record: record))
            case .failure(let error):
                print("❌ Erro ao executar query:", error)
            }
        }
        queryOperation.queryResultBlock = { _ in
            Task { @MainActor in
                self.isFetchingNews = false
                self.news = items
            }
        }
        
        CKContainer.default().publicCloudDatabase.add(queryOperation)
        
    }
}
