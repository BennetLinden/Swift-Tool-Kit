//
//  OAuthAuthenticator.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 26/08/2024.
//

import Alamofire
import Foundation

class OAuthAuthenticator: Authenticator {
    typealias Credential = OAuthCredential

    let network: Network
    let keychainStorage: KeychainStorage

    init(
        network: Network,
        keychainStorage: KeychainStorage
    ) {
        self.network = network
        self.keychainStorage = keychainStorage
    }

//    convenience init() {
//        @Injected(\.network) var network
//        @Injected(\.keychainStorage) var keychainStorage
//        self.init(
//            network: network,
//            keychainStorage: keychainStorage
//        )
//    }

    func apply(
        _ credential: OAuthCredential,
        to urlRequest: inout URLRequest
    ) {
        urlRequest.headers.add(.authorization(
            bearerToken: credential.accessToken
        ))
    }

    func refresh(
        _ credential: OAuthCredential,
        for session: Alamofire.Session,
        completion: @escaping (Result<OAuthCredential, Error>) -> Void
    ) {
        Task {
            do {
                let credential = try await refreshCredential(
                    with: credential.refreshToken
                )
                try keychainStorage.set(credential)
                completion(.success(credential))
            } catch {
                completion(.failure(error))
            }
        }
    }

    private func refreshCredential(with refreshToken: String) async throws -> OAuthCredential {
        let params: [String: Any] = [
            "refresh_token": refreshToken,
        ]
        do {
            return try await network.request(
                Route(.post, .authentication(.refreshToken), with: params),
                response: OAuthCredential.self,
                decoder: JSONDecoder()
            )
            .body
        } catch {
            // Determine if refresh token is expired or invalid
            // throw NetworkError.authentication(.refreshTokenExpiredOrInvalid)

            throw error
        }
    }

    func didRequest(
        _ urlRequest: URLRequest,
        with response: HTTPURLResponse,
        failDueToAuthenticationError error: Error
    ) -> Bool {
        NetworkError(error) == NetworkError.authentication(.unauthorized)
    }

    func isRequest(
        _ urlRequest: URLRequest,
        authenticatedWith credential: OAuthCredential
    ) -> Bool {
        urlRequest.headers.contains(
            where: { $0 == HTTPHeader.authorization(bearerToken: credential.accessToken) }
        )
    }
}
