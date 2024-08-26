//
//  Shape+Extensions.swift
//  Swift Tool Kit
//
//  Created by Bennet van der Linden on 26/08/2024.
//

import SwiftUI

extension Shape {
    func style<Fill: ShapeStyle, Stroke: ShapeStyle>(
        fill fillStyle: Fill,
        stroke strokeStyle: Stroke,
        lineWidth: CGFloat = 1
    ) -> some View {
        stroke(strokeStyle, lineWidth: lineWidth)
            .background(fill(fillStyle))
    }
}

extension InsettableShape {
    func style<Fill: ShapeStyle, Stroke: ShapeStyle>(
        fill fillStyle: Fill,
        strokeBorder strokeStyle: Stroke,
        lineWidth: CGFloat = 1
    ) -> some View {
        strokeBorder(strokeStyle, lineWidth: lineWidth)
            .background(fill(fillStyle))
    }

    func style<Fill: ShapeStyle, StrokeContent: ShapeStyle>(
        fill fillStyle: Fill,
        strokeContent: StrokeContent,
        strokeStyle: StrokeStyle
    ) -> some View {
        strokeBorder(strokeContent, style: strokeStyle)
            .background(fill(fillStyle))
    }
}
