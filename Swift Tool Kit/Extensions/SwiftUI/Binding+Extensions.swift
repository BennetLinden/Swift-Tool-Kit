//
//  Binding+Extensions.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 26/08/2024.
//

import SwiftUI

/// This extension adds an `onSet` function that accepts an action closure which is
/// called when the binding value is set. This is useful when we only want to respond
/// to changes on the setter of the binding (e.g. a component that changes a value)
/// compared to an `@State` or `@Published` property that is being passed as
/// a binding.
///
/// Consider the following use case:
///
///     struct ContentView: View {
///         @State var isOn: Bool = false
///
///         var body: some View {
///             Toggle("Toggle", isOn: $isOn)
///         }
///     }
///
/// If we want to respond to changes of the `isOn` state property we are not only reacting
/// to changes from the Toggle, but to anything that changes the `isOn` property of
/// `ContentView`.
///
/// Alternatively, we can use the `onSet` binding extension to call a function when the
/// `isOn` property is changed only by user interaction with the Toggle:
///
///     struct ContentView: View {
///         @State var isOn: Bool = false
///
///         var body: some View {
///             Toggle("Toggle", isOn: $isOn.onSet(action: onToggle))
///         }
///
///         func onToggle(isOn: Bool) {
///             // Do something when the user interacts with the Toggle
///         }
///     }
///
extension Binding {
    func onSet(action: @escaping (Value) -> Void) -> Binding {
        Binding(
            get: { self.wrappedValue },
            set: {
                self.wrappedValue = $0
                action($0)
            }
        )
    }
}
