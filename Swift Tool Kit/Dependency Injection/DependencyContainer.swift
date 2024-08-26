//
//  DependencyContainer.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 26/08/2024.
//

import Alamofire
import Foundation

struct DependencyContainer {
    private static var shared = DependencyContainer()

    /// A static subscript for accessing the `value` of `InjectionKey` instances.
    static subscript<Key: InjectionKey>(key: Key.Type) -> Key.Value {
        key.value
    }

    /// A static subscript accessor for reading dependencies in the shared container.
    static subscript<Value>(_ keyPath: KeyPath<DependencyContainer, Value>) -> Value {
        DependencyContainer.shared[keyPath: keyPath]
    }
}

// MARK: - Network

extension DependencyContainer {
    private struct NetworkKey: InjectionKey {
        static let value: Network = NetworkService(session: .default)
    }

    var network: Network {
        DependencyContainer[NetworkKey.self]
    }
}

// MARK: - Keychain

extension DependencyContainer {
    private struct KeychainStorageKey: InjectionKey {
        static let value: KeychainStorage = KeychainStorageService()
    }

    var keychainStorage: KeychainStorage {
        DependencyContainer[KeychainStorageKey.self]
    }
}

// MARK: - Authentication Interceptor

extension DependencyContainer {
    private struct AuthenticationInterceptorKey: InjectionKey {
        static let value = AuthenticationInterceptor(
            authenticator: OAuthAuthenticator()
        )
    }

    var authenticationInterceptor: AuthenticationInterceptor<OAuthAuthenticator> {
        DependencyContainer[AuthenticationInterceptorKey.self]
    }
}
