//
//  Endpoint.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 26/08/2024.
//

import Alamofire
import Foundation

enum EndpointError: Error {
    case invalidURL
}

struct Endpoint: URLConvertible {
    let baseURL: URL
    let path: String
    var queryItems: [URLQueryItem]?

    func asURL() throws -> URL {
        var components = URLComponents(
            url: baseURL,
            resolvingAgainstBaseURL: true
        )
        components?.path = path
        components?.queryItems = queryItems

        guard let url = components?.url else {
            throw EndpointError.invalidURL
        }
        
        return url
    }
}

// Examples

extension URL {
    static var example: URL {
        URL(string: "www.example.com/api")!
    }
}

extension URLConvertible where Self == Endpoint {
    static func authentication(
        _ authentication: Endpoint.Authentication,
        with queryItems: [URLQueryItem]? = nil
    ) -> Endpoint {
        Endpoint(
            baseURL: .example,
            path: authentication.path,
            queryItems: queryItems
        )
    }

    static func user(
        _ user: Endpoint.User,
        with queryItems: [URLQueryItem]? = nil
    ) -> Endpoint {
        Endpoint(
            baseURL: .example,
            path: user.path,
            queryItems: queryItems
        )
    }
}

extension Endpoint {
    // MARK: - Authentication

    enum Authentication {
        case register
        case login
        case refreshToken

        var path: String {
            switch self {
            case .register:
                "/register"
            case .login:
                "/login"
            case .refreshToken:
                "/refresh"
            }
        }
    }

    // MARK: - User

    enum User {
        case me

        var path: String {
            switch self {
            case .me:
                "/me"
            }
        }
    }
}
