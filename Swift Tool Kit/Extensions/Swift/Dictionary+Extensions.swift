//
//  Dictionary+Extensions.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 26/08/2024.
//

import Foundation

extension Dictionary {
    init(@DictionaryBuilder<Key, Value> builder: () -> Dictionary) {
        self = builder()
    }
}
