//
//  CSFont.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 29/3/24.
//

import Foundation
import SwiftUI

struct CSFont {
    var font: UIFont

    static func inter(_ size: CGFloat, weight: FontWeight) -> CSFont {
        let font = UIFont.font(type: .inter, weight: weight, size: size)
        return CSFont(font: font)
    }
}

struct CSFontModifier: ViewModifier {
    var font: CSFont
    var color: Color

    func body(content: Content) -> some View {
        content
            .textSelection(.enabled)
            .font(Font(self.font.font))
            .foregroundColor(color)
    }
}

extension View {
    func CSFont(_ font: CSFont, color: Color) -> some View {
        modifier(CSFontModifier(font: font, color: color))
    }
}
