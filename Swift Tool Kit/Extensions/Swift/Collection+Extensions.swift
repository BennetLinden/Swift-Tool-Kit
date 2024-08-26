//
//  Collection+Extensions.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 20/08/2024.
//

import Foundation

infix operator ?=

extension Collection {
    var isNotEmpty: Bool {
        !isEmpty
    }

    func ifEmpty(_ defaultValue: @autoclosure () -> Self) -> Self {
        isEmpty ? defaultValue() : self
    }
    
    /// Custom operator that returns a default value for a given empty Collection.
    ///
    ///     let strings: [String] = []
    ///     let values = strings ?= ["A", "B", "C"]
    ///     print(values)
    ///     // Prints "["A", "B", "C"]"
    ///
    /// - Parameters:
    ///   - lhs: The given (possibly) empty Collection
    ///   - rhs: The value to be returned when `lhs` is Empty
    /// - Returns: The `rhs` value if `lhs` value is empty.
    static func ?= (lhs: Self, rhs: Self) -> Self {
        lhs.ifEmpty(rhs)
    }

    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }

    subscript(indexSet: any Sequence<Index>) -> [Element] {
        indexSet.map { self[$0] }
    }
}
