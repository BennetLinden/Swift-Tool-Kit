//
//  KeychainStorage.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 26/08/2024.
//

import Foundation

protocol KeychainStorage {
    var authenticationCredential: OAuthCredential? { get throws }
    func set(_ authenticationCredential: OAuthCredential?) throws
}
