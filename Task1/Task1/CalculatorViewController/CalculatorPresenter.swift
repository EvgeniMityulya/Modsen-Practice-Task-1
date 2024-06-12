//
//  CalculatorPresenter.swift
//  Task1
//
//  Created by Евгений Митюля on 6/11/24.
//

import UIKit

protocol CalculatorViewOutput {
    func calculatorButtonTapped(with tag: Int)
}

final class CalculatorPresenter: CalculatorViewOutput {
    
    var firstNumber = 0.0
       var secondNumber = 0.0
       var currentOperation: Operation = .none
       var isTypingNumber = false
       
       private unowned let input: CalculatorInput
       
       init(input: CalculatorInput) {
           self.input = input
       }
       
       func calculatorButtonTapped(with tag: Int) {
           print(tag)
           switch tag {
           case 0...9:
               numberButtonTapped(value: tag)
           case 10:
               resetButtonTapped()
           case 11:
               toggleSignButtonTapped()
           case 12:
               percentButtonTapped()
           case 13:
               operationButtonTapped(operation: .divide)
           case 14:
               operationButtonTapped(operation: .multiply)
           case 15:
               operationButtonTapped(operation: .subtract)
           case 16:
               operationButtonTapped(operation: .add)
           case 17:
               equalButtonTapped()
           case 18:
               dotButtonTapped()
           default:
               print("Error")
           }
       }
       
       private func numberButtonTapped(value: Int) {
           if isTypingNumber {
               if let text = input.inputLabelText {
                   input.updateInputLabel(with: "\(text)\(value)")
               }
           } else {
               input.updateInputLabel(with: "\(value)")
               isTypingNumber = true
           }
       }
       
       private func resetButtonTapped() {
           input.resetLabels()
           currentOperation = .none
           firstNumber = 0
           secondNumber = 0
           isTypingNumber = false
       }
       
       private func operationButtonTapped(operation: Operation) {
           if let text = input.inputLabelText, let number = Double(text) {
               firstNumber = number
               isTypingNumber = false
               currentOperation = operation
           }
       }
       
       private func percentButtonTapped() {
           if let text = input.inputLabelText, let number = Double(text) {
               input.updateInputLabel(with: "\(number / 100)")
           }
       }
       
       private func toggleSignButtonTapped() {
           if let text = input.inputLabelText, let number = Double(text) {
               input.updateInputLabel(with: "\(-number)")
           }
       }
       
       private func equalButtonTapped() {
           if let text = input.inputLabelText, let number = Double(text) {
               secondNumber = number
               var result: Double = 0
               
               switch currentOperation {
               case .add:
                   result = firstNumber + secondNumber
               case .subtract:
                   result = firstNumber - secondNumber
               case .multiply:
                   result = firstNumber * secondNumber
               case .divide:
                   result = firstNumber / secondNumber
               case .none:
                   return
               }
               
               input.updateResultLabel(with: result)
               input.updateInputLabel(with: "0")
               currentOperation = .none
               isTypingNumber = false
           }
       }
       
       private func dotButtonTapped() {
           if let text = input.inputLabelText, !text.contains(".") {
               input.updateInputLabel(with: "\(text).")
           }
       }
}
