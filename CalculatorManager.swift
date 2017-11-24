//
//  CalculatorManager.swift
//  Calculator
//
//  Created by Leandro Jabur on 11/22/17.
//  Copyright © 2017 CINQ. All rights reserved.
//

import Foundation

struct CalculatorManager {
    
    enum Operation {
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double,Double)->Double)
        case equals
        case unknoun
    }
    
    private struct PreviousBinaryeOperation{
        let function:(Double,Double) -> Double
        let firstOperand:Double
        
        func perform(with secondOperand:Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    private var acumulator : Double = 0.0
    private var binaryOperationMemory:PreviousBinaryeOperation?
    private let operations = ["+":Operation.BinaryOperation({$0+$1}),
                             "-":Operation.BinaryOperation({$0-$1}),
                             "x":Operation.BinaryOperation({$0*$1}),
                             "÷":Operation.BinaryOperation({$0/$1}),
                             "±":Operation.UnaryOperation({-$0}),
                             "√":Operation.UnaryOperation(sqrt),
                             "=":Operation.equals]
    
   
    var result : Double{
        get{
            return acumulator
        }
    }
    
    mutating func performOperation(_ symbol:String) {
        guard let operation = operations[symbol] else {
            return
        }
        switch operation {
        case .UnaryOperation(let op):
            acumulator = op(acumulator)
        case .BinaryOperation(let op):
            binaryOperationMemory = PreviousBinaryeOperation(function: op, firstOperand: acumulator)
        case .equals:
            doPreviousBinaryOperation()
            break
            
        default:
            break
        }
    }
    
    mutating func doPreviousBinaryOperation() {
        guard let memory = binaryOperationMemory else { return }
        acumulator = memory.perform(with: acumulator)
        self.binaryOperationMemory = nil
    }
    
    mutating func setOperate(_ operand:Double){
       self.acumulator = operand
    }
    
}
