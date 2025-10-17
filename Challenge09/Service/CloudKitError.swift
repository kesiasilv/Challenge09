//
//  CloudKitError.swift
//  Challenge09
//
//  Created by Lizandra Malta on 17/10/25.
//

import SwiftUI

enum CloudKitError: String, LocalizedError {
    case iCloudAccountNotFound
    case iCloudAccountNotDeterminate
    case iCloudAccountRestricted
    case iCloudAccountUnknown
}
