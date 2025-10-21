//
//  ImageHelpers.swift
//  Challenge09
//
//  Created by Lizandra Malta on 21/10/25.
//

import Foundation
import CloudKit

class ImageHelper {
    
    static let shared = ImageHelper()
    
    public func saveTempImage(data: Data) -> URL? {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString + ".png")
        do {
            try data.write(to: url)
            return url
        } catch {
            print("❌ Erro ao salvar imagem temporária:", error)
            return nil
        }
    }
}
