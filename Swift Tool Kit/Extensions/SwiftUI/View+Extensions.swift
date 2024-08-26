//
//  View+Extensions.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 26/08/2024.
//

import SwiftUI

extension View {
    func enabled(_ isEnabled: Bool) -> some View {
        disabled(!isEnabled)
            .environment(\.isEnabled, isEnabled)
    }

    func loading(_ isLoading: Bool) -> some View {
        disabled(isLoading)
            .environment(\.isLoading, isLoading)
    }
}
