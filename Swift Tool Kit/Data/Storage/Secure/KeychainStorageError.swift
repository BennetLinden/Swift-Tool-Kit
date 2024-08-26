//
//  KeychainStorageError.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 26/08/2024.
//

import Foundation

enum KeychainStorageError: Error {
    case itemNotFound
    case invalidData
    case invalidStatus(OSStatus, description: String?)

    static func invalidStatus(_ status: OSStatus) -> KeychainStorageError {
        .invalidStatus(status, description: SecCopyErrorMessageString(status, nil) as? String)
    }
}
