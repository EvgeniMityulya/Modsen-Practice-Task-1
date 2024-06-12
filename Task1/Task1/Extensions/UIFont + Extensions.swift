//
//  UIFont + Extensions.swift
//  Task1
//
//  Created by Евгений Митюля on 6/12/24.
//

import UIKit

enum InterFontStyle: String {
    case regular = "Inter-Regular"
}

extension UIFont {
    static func Inter(ofSize size: CGFloat, style: InterFontStyle) -> UIFont {
        return UIFont(name: style.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}
