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
