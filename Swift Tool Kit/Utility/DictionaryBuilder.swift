//
//  DictionaryBuilder.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 20/08/2024.
//

import Foundation

@resultBuilder
struct DictionaryBuilder<Key: Hashable, Value> {
    typealias Component = [Key: Value]

    static func buildBlock() -> Component { [:] }

    static func buildBlock(_ components: Component...) -> Component {
        components.reduce(into: [:]) {
            $0.merge($1) { _, new in new }
        }
    }

    static func buildBlock(_ component: Component) -> Component {
        component
    }

    static func buildOptional(_ component: Component?) -> Component {
        component ?? [:]
    }

    static func buildEither(first component: Component) -> Component {
        component
    }

    static func buildEither(second component: Component) -> Component {
        component
    }
}
