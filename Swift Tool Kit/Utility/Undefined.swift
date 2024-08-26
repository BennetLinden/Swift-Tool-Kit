//
//  Undefined.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 20/08/2024.
//

import Foundation

func undefined<T>(_ message: String?) -> T {
    if let message {
        fatalError("Undefined: \(message)")
    } else {
        fatalError("Undefined")
    }
}
