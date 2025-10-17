//
//  Untitled.swift
//  Challenge09
//
//  Created by Lizandra Malta on 17/10/25.
//

import Foundation
import CloudKit

@Observable
class CloudKitViewModel {
    
    init(){
        getStatus()
    }
    
    func getStatus(){
        CKContainer.default().accountStatus { status, error in
            DispatchQueue.main.async {
                switch status {
                case .available:
                    print("CLOUD KIT STATUS -> OK")
                case .couldNotDetermine:
                    print("CLOUD KIT STATUS -> \(CloudKitError.iCloudAccountNotDeterminate.rawValue)")
                case .noAccount:
                    print("CLOUD KIT STATUS -> \(CloudKitError.iCloudAccountNotFound.rawValue)")
                case .restricted:
                    print("CLOUD KIT STATUS -> \(CloudKitError.iCloudAccountRestricted.rawValue)")
                case .temporarilyUnavailable:
                    print("CLOUD KIT STATUS -> \(CloudKitError.iCloudAccountUnknown.rawValue)")
                default:
                    print("CLOUD KIT STATUS -> \(CloudKitError.iCloudAccountUnknown.rawValue)")
                }
            }
        }
    }
    

}
