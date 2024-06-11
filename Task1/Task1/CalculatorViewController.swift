//
//  CalculatorViewController.swift
//  Task1
//
//  Created by Евгений Митюля on 6/11/24.
//

import UIKit


protocol CalculatorInput: AnyObject {
}

final class CalculatorViewController: UIViewController {

    var output: CalculatorViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
    }


}

extension CalculatorViewController: CalculatorInput {
    
}
