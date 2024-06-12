//
//  CalculatorViewController.swift
//  Task1
//
//  Created by Евгений Митюля on 6/11/24.
//

import UIKit

protocol CalculatorInput: AnyObject {
    var inputLabelText: String? { get }
    func resetLabels()
    func updateInputLabel(with text: String)
    func updateResultLabel(with value: Double)
}

final class CalculatorViewController: UIViewController {
    
    var output: CalculatorViewOutput?
    
    private var horizontalRows = [UIStackView]()
    private var calculatorButtons = [UIButton]()
    
    // buttons stack
    private lazy var calculatorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // input and output fields stack
    private lazy var outputStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var inputLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Inter(ofSize: 45, style: .regular)
        label.numberOfLines = 1
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Inter(ofSize: 45, style: .regular)
        label.numberOfLines = 1
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.backgroundColor
        self.resetLabels()
        self.setupUI()
    }
    
    @objc func calculatorButtonTapped(_ sender: UIButton) {
        let tag = sender.tag
        output?.calculatorButtonTapped(with: tag)
    }
}

extension CalculatorViewController: CalculatorInput {
    var inputLabelText: String? {
        return inputLabel.text
    }
    
    func updateResultLabel(with value: Double) {
        self.resultLabel.text = String(value)
    }
    
    func updateInputLabel(with text: String) {
        self.inputLabel.text = text
    }
    
    func resetLabels() {
        self.inputLabel.text = "0"
        self.resultLabel.text = ""
    }
}

// MARK: - UI Configuration
private extension CalculatorViewController {
    func setupUI() {
        self.createCalculatorButtons()
        self.setupCalculatorStackView()
        self.fillStackView()
    }
    
    func setupCalculatorStackView() {
        self.view.addSubview(
            self.calculatorStackView,
            self.separatorView,
            self.outputStackView
        )
        
        self.outputStackView.addArrangedSubview(
            self.inputLabel,
            self.resultLabel
        )
        
        NSLayoutConstraint.activate([
            self.calculatorStackView.heightAnchor.constraint(equalToConstant: 455),
            self.calculatorStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 19),
            self.calculatorStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -19),
            self.calculatorStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -4),
            
            self.separatorView.bottomAnchor.constraint(equalTo: self.calculatorStackView.topAnchor, constant: -25),
            self.separatorView.leadingAnchor.constraint(equalTo: self.calculatorStackView.leadingAnchor),
            self.separatorView.trailingAnchor.constraint(equalTo: self.calculatorStackView.trailingAnchor),
            self.separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            
            self.outputStackView.bottomAnchor.constraint(equalTo: self.separatorView.topAnchor, constant: -25),
            self.outputStackView.leadingAnchor.constraint(equalTo: self.calculatorStackView.leadingAnchor),
            self.outputStackView.trailingAnchor.constraint(equalTo: self.calculatorStackView.trailingAnchor),
            self.outputStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 38),
        ])
    }
    
    func createCalculatorButtons() {
        // Create reset button
        let resetButton = UIButton()
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.setTitle("C", for: .normal)
        resetButton.backgroundColor = UIColor.CalculatorButtons.red
        resetButton.tintColor = UIColor.CalculatorButtons.background
        resetButton.tag = 10
        calculatorButtons.append(resetButton)
        
        // Create all numbers
        for i in 0...9 {
            let button = UIButton()
            button.setTitle(String(i), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor.CalculatorButtons.background
            button.tag = i
            button.setTitleColor(UIColor.darkWhiteColor, for: .normal)
            calculatorButtons.append(button)
        }
        
        // Create operations
        for imageName in SystemImage.allCases {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            let image = UIImage(systemName: imageName.rawValue)?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 24.5))
            button.setImage(image, for: .normal)
            button.backgroundColor = UIColor.CalculatorButtons.background
            button.tintColor = (imageName != .plusMinus) ? UIColor.CalculatorButtons.green : UIColor.darkWhiteColor
            calculatorButtons.append(button)
            
            switch imageName {
            case .plusMinus:
                button.currentImage?.accessibilityIdentifier = "+/-"
                button.tag = 11
            case .percent:
                button.currentImage?.accessibilityIdentifier = "%"
                button.tag = 12
            case .divide:
                button.currentImage?.accessibilityIdentifier = "/"
                button.tag = 13
            case .multiply:
                button.currentImage?.accessibilityIdentifier = "x"
                button.tag = 14
            case .minus:
                button.currentImage?.accessibilityIdentifier = "-"
                button.tag = 15
            case .plus:
                button.currentImage?.accessibilityIdentifier = "+"
                button.tag = 16
            case .equal:
                button.currentImage?.accessibilityIdentifier = "="
                button.backgroundColor = UIColor.CalculatorButtons.green
                button.tintColor = UIColor.CalculatorButtons.background
                button.tag = 17
            }
        }
        
        // Create dot button
        let dotButton = UIButton()
        dotButton.translatesAutoresizingMaskIntoConstraints = false
        dotButton.setTitle(".", for: .normal)
        dotButton.tag = 18
        dotButton.backgroundColor = UIColor.CalculatorButtons.background
        dotButton.setTitleColor(UIColor.darkWhiteColor, for: .normal)
        calculatorButtons.append(dotButton)
        
        calculatorButtons.forEach {
            $0.addTarget(self, action: #selector(calculatorButtonTapped), for: .touchUpInside)
            $0.titleLabel?.font = .Inter(ofSize: 36, style: .regular)
        }
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
