//
//  CalculatorPresenter.swift
//  Task1
//
//  Created by Евгений Митюля on 6/11/24.
//

import UIKit

protocol CalculatorViewOutput {
}

final class CalculatorPresenter: CalculatorViewOutput {
    
    private unowned let input: CalculatorInput
    
    init(input: CalculatorInput) {
        self.input = input
    }
}
