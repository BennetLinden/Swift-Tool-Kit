//
//  InjectionKey.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 26/08/2024.
//

import Foundation

protocol InjectionKey {
    /// The associated type representing the type of the dependency injection key's value.
    associatedtype Value

    /// The value for the dependency injection key.
    static var value: Self.Value { get }
}
