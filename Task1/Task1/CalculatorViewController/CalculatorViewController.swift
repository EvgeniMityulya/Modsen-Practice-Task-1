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
    
    private var horizontalRows = [UIStackView]()
    private var calculatorButtons = [UIButton]()
    
    var buttonSize: CGFloat = 0
    
    private lazy var calculatorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.backgroundColor
        self.setupUI()
    }
}

extension CalculatorViewController: CalculatorInput {
    
}

private extension CalculatorViewController {
    func setupUI() {
        self.createCalculatorButtons()
        self.setupCalculatorStackView()
        self.fillStackView()
    }
    
    func setupCalculatorStackView() {
        self.view.addSubview(
            self.calculatorStackView
        )
        
        NSLayoutConstraint.activate([
            self.calculatorStackView.heightAnchor.constraint(equalToConstant: 455),
            self.calculatorStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 19),
            self.calculatorStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -19),
            self.calculatorStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -4),
        ])
    }
    
    func createCalculatorButtons() {
        // Create reset button
        let resetButton = UIButton()
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.setTitle("C", for: .normal)
        resetButton.backgroundColor = UIColor.CalculatorButtons.red
        calculatorButtons.append(resetButton)
        
        // Create all numbers
        for i in 0...9 {
            let button = UIButton()
            button.setTitle(String(i), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor.CalculatorButtons.background
            button.tag = i
            calculatorButtons.append(button)
        }
        
        // Create operations
        for imageName in SystemImage.allCases {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            let image = UIImage(systemName: imageName.rawValue)
            button.setImage(image, for: .normal)
            button.backgroundColor = UIColor.CalculatorButtons.background
            button.tintColor = (imageName != .plusMinus) ? UIColor.CalculatorButtons.green : UIColor.white
            calculatorButtons.append(button)
            
            switch imageName {
            case .plusMinus:
                button.currentImage?.accessibilityIdentifier = "+/-"
            case .minus:
                button.currentImage?.accessibilityIdentifier = "-"
            case .multiply:
                button.currentImage?.accessibilityIdentifier = "x"
            case .divide:
                button.currentImage?.accessibilityIdentifier = "/"
            case .equal:
                button.currentImage?.accessibilityIdentifier = "="
            case .plus:
                button.currentImage?.accessibilityIdentifier = "+"
            case .percent:
                button.currentImage?.accessibilityIdentifier = "%"
            }
        }
        
        // Create dot button
        let dotButton = UIButton()
        dotButton.translatesAutoresizingMaskIntoConstraints = false
        dotButton.setTitle(".", for: .normal)
        dotButton.backgroundColor = UIColor.CalculatorButtons.background
        dotButton.tintColor = UIColor.CalculatorButtons.green
        calculatorButtons.append(dotButton)
        
        
    }
    
    func fillStackView() {
        let buttonTitles = [
            ["C", "+/-", "%", "/"],
            ["7", "8", "9", "x"],
            ["4", "5", "6", "-"],
            ["1", "2", "3", "+"],
            ["0", ".", "="]
        ]
        
        for row in buttonTitles {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.alignment = .fill
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = 20
            calculatorStackView.addArrangedSubview(rowStackView)
            
            for title in row {
                let button = calculatorButtons.first { $0.currentTitle == title || $0.currentImage?.accessibilityIdentifier == title }
                if let button = button {
                    let cornerRadius: CGFloat = 9
                    button.layer.cornerRadius = cornerRadius
                    button.translatesAutoresizingMaskIntoConstraints = false
                    button.clipsToBounds = true
                    rowStackView.addArrangedSubview(button)
                }
            }
            
            
        }
        
        // Fill last row
        if let lastStackView = calculatorStackView.arrangedSubviews.last as? UIStackView {
            lastStackView.distribution = .equalSpacing
            let spacing = lastStackView.spacing / 2
            for button in lastStackView.arrangedSubviews {
                
                if let button = button as? UIButton, button.currentImage?.accessibilityIdentifier == "=" {
                    button.widthAnchor.constraint(equalTo: lastStackView.widthAnchor, multiplier: 0.5, constant: -spacing).isActive = true
                } else {
                    button.widthAnchor.constraint(equalTo: lastStackView.widthAnchor, multiplier: 0.25, constant: -1.5 * spacing).isActive = true
                }
            }
            
        }
        
    }
}
