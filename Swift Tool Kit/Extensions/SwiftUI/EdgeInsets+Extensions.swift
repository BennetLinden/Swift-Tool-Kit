//
//  EdgeInsets+Extensions.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 26/08/2024.
//

import SwiftUI

extension EdgeInsets {
    init(all inset: CGFloat) {
        self.init(
            top: inset,
            leading: inset,
            bottom: inset,
            trailing: inset
        )
    }

    init(vertical: CGFloat, horizontal: CGFloat) {
        self.init(
            top: vertical,
            leading: horizontal,
            bottom: vertical,
            trailing: horizontal
        )
    }

    static var zero: EdgeInsets {
        EdgeInsets(all: .zero)
    }

    static func top(_ top: CGFloat) -> EdgeInsets {
        EdgeInsets(top: top, leading: .zero, bottom: .zero, trailing: .zero)
    }

    static func leading(_ leading: CGFloat) -> EdgeInsets {
        EdgeInsets(top: .zero, leading: leading, bottom: .zero, trailing: .zero)
    }

    static func bottom(_ bottom: CGFloat) -> EdgeInsets {
        EdgeInsets(top: .zero, leading: .zero, bottom: bottom, trailing: .zero)
    }

    static func trailing(_ trailing: CGFloat) -> EdgeInsets {
        EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: trailing)
    }

    static func vertical(_ vertical: CGFloat) -> EdgeInsets {
        EdgeInsets(top: vertical, leading: .zero, bottom: vertical, trailing: .zero)
    }

    static func horizontal(_ horizontal: CGFloat) -> EdgeInsets {
        EdgeInsets(top: .zero, leading: horizontal, bottom: .zero, trailing: horizontal)
    }

    func appending(_ insets: EdgeInsets) -> EdgeInsets {
        EdgeInsets(
            top: top + insets.top,
            leading: leading + insets.leading,
            bottom: bottom + insets.bottom,
            trailing: trailing + insets.trailing
        )
    }

    static func + (lhs: EdgeInsets, rhs: EdgeInsets) -> EdgeInsets {
        lhs.appending(rhs)
    }
}

extension EdgeInsets: ExpressibleByFloatLiteral {
    public init(floatLiteral value: FloatLiteralType) {
        self.init(all: value)
    }
}

extension EdgeInsets: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(all: CGFloat(value))
    }
}
