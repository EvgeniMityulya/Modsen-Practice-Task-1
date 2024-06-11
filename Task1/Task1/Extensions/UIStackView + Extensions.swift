//
//  UIStackView + Extensions.swift
//  Task1
//
//  Created by Евгений Митюля on 6/11/24.
//

import UIKit

extension UIStackView {
    func addArrangedSubview(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
