//
//  Result+Extensions.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 26/08/2024.
//

import Foundation

extension Result where Failure == Error {
    init(catching body: () async throws -> Success) async {
        do {
            self = try await .success(body())
        } catch {
            self = .failure(error)
        }
    }

    var error: Failure? {
        switch self {
        case .failure(let error): error
        default: nil
        }
    }
}
