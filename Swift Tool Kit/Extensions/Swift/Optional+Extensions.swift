//
//  Optional+Extensions.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 26/08/2024.
//

import Foundation

extension Optional where Wrapped: Collection {
    var isEmptyOrNil: Bool {
        self?.isEmpty ?? true
    }

    var isNotEmptyOrNil: Bool {
        self?.isNotEmpty ?? false
    }
}
