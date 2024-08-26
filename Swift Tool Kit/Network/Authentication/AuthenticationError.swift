//
//  AuthenticationError.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 26/08/2024.
//

import Foundation

enum AuthenticationError: Error, Equatable {
    case unauthorized
    case refreshTokenExpiredOrInvalid
    case missingCredential
    case excessiveRefresh
}
