//
//  EnvironmentValues+Extensions.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 26/08/2024.
//

import SwiftUI

extension EnvironmentValues {
    // MARK: - isLoading

    private struct IsLoadingKey: EnvironmentKey {
        static let defaultValue = false
    }

    var isLoading: Bool {
        get { self[IsLoadingKey.self] }
        set { self[IsLoadingKey.self] = newValue }
    }
}
