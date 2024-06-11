//
//  UIColor + Extensions.swift
//  Task1
//
//  Created by Евгений Митюля on 6/11/24.
//

import UIKit

extension UIColor {
    struct CalculatorButtons {
        static var green: UIColor {
            return UIColor(named: "greenButtonColor") ?? .green
        }
        
        static var red: UIColor {
            return UIColor(named: "redButtonColor") ?? .red
        }
        
        static var background: UIColor {
            return UIColor(named: "backgroundButtonColor") ?? .white
        }
    }
    
    static var backgroundColor: UIColor {
        return UIColor(named: "backgroundCalculatorColor") ?? .white
    }
}
