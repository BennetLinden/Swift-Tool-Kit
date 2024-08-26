//
//  Array+Extensions.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 26/08/2024.
//

import Foundation
import SwiftUI

extension Array {
    init(@ArrayBuilder<Element> builder: () -> [Element]) {
        self.init(builder())
    }

    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

extension Array where Element == Text {
    func joined() -> Text {
        guard let first = first else {
            return Text("")
        }
        return dropFirst().reduce(first, +)
    }

    func joined(separator: Text) -> Text {
        guard let first = first else {
            return Text("")
        }

        return dropFirst().reduce(first) { partialResult, text in
            partialResult + separator + text
        }
    }

    func joined(separator: String) -> Text {
        joined(separator: Text(separator))
    }
}
