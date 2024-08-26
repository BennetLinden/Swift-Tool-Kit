//
//  Sequence+Extensions.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 26/08/2024.
//

import Foundation

extension Sequence {
    func sorted<Value: Comparable>(
        by keyPath: KeyPath<Element, Value>,
        order: SortOrder = .forward
    ) -> [Element] {
        sorted(using: KeyPathComparator(keyPath, order: order))
    }

    func min<Value: Comparable>(
        by keyPath: KeyPath<Element, Value>
    ) -> Element? {
        self.min { lhs, rhs in
            lhs[keyPath: keyPath] < rhs[keyPath: keyPath]
        }
    }

    func min<Value: Comparable>(
        by keyPath: KeyPath<Element, Value?>
    ) -> Element? {
        filter {
            $0[keyPath: keyPath] != nil
        }
        .min { lhs, rhs in
            lhs[keyPath: keyPath]! < rhs[keyPath: keyPath]!
        }
    }

    func max<Value: Comparable>(
        by keyPath: KeyPath<Element, Value>
    ) -> Element? {
        self.max { lhs, rhs in
            lhs[keyPath: keyPath] < rhs[keyPath: keyPath]
        }
    }

    func max<Value: Comparable>(
        by keyPath: KeyPath<Element, Value?>
    ) -> Element? {
        filter {
            $0[keyPath: keyPath] != nil
        }
        .max { lhs, rhs in
            lhs[keyPath: keyPath]! < rhs[keyPath: keyPath]!
        }
    }
}

extension Sequence where Element: Hashable {
    func distinct() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
