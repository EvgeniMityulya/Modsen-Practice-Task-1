//
//  CalculatorBuilder.swift
//  Task1
//
//  Created by Евгений Митюля on 6/11/24.
//

import Foundation

enum CalculatorBuilder {
    static func setupModule() -> CalculatorViewController {
        let viewController = CalculatorViewController()
        let presenter = CalculatorPresenter(input: viewController)
        viewController.output = presenter
        return viewController
    }
}
