//
//  UIView + Extensions.swift
//  Task1
//
//  Created by Евгений Митюля on 6/11/24.
//

import UIKit

extension UIView {
    func addSubview(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
