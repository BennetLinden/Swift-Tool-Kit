//
//  Toggle+Extensions.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 26/08/2024.
//

import SwiftUI

extension Toggle {
    @MainActor init(
        isOn: Binding<Bool>,
        onToggle action: @escaping (Bool) -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.init(
            isOn: isOn.onSet(action: action),
            label: label
        )
    }
}

extension Toggle where Label == Text {
    @MainActor init<S: StringProtocol>(
        _ title: S,
        isOn: Binding<Bool>,
        onToggle action: @escaping (Bool) -> Void
    ) {
        self.init(
            title,
            isOn: isOn.onSet(action: action)
        )
    }
}
