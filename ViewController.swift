//
//  ViewController.swift
//  Calculator
//
//  Created by Rafagan Abreu on 13/11/17.
//  Copyright © 2017 CINQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    var userIsTyping: Bool = false
    var manager = CalculatorManager()
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            var valor = newValue
            if valor == -0 { valor = 0 }
            display.text = String(valor)
        }
    }
    
    @IBAction func touchClear(_ sender: UIButton) {
        userIsTyping = false
        display.text = "0"
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping {
            let textDisplay = display.text ?? ""
            
            if textDisplay == "0" && digit == "0" {
                display.text = "0"
                userIsTyping = false
            } else {
                display.text = textDisplay + digit
            }
            
        } else {
            display.text = digit
            userIsTyping = true
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        if userIsTyping {
            userIsTyping = false
            manager.setOperate(displayValue)
        }
        
        if let matSymbol = sender.currentTitle{
            manager.performOperation(matSymbol)
        }
        
        displayValue = manager.result
    }
}
