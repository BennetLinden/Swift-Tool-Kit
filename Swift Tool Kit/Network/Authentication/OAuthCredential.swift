//
//  OAuthCredential.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 26/08/2024.
//

import Alamofire
import Foundation

struct OAuthCredential: AuthenticationCredential {
    let accessToken: String
    let refreshToken: String

    /// Requirement from `AuthenticationCredential`.
    ///
    /// Determine this based on the expiration date of the access token.
    var requiresRefresh: Bool {
        false
    }
}

extension OAuthCredential: Codable {
    enum CodingKeys: String, CodingKey {
        case accessToken
        case refreshToken
    }
}
