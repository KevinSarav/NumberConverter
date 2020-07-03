//
//  Decimal.swift
//  NumberConverter
//
//  Created by Saravia, Kevin on 7/3/20.
//  Copyright © 2020 Saravia, Kevin. All rights reserved.
//

import Foundation

class Decimal
{
    // This class is just for casting between a String to a double for decimals.
    // Meant to be used by Converter class.
    
    func fromDouble(_ number: Double) -> String {
        return number.description
    }
    
    func toDouble(_ number: String) -> (check: Bool, result: Double) {
        if let convertedNum = Double(number) {
            return (true, convertedNum)
        }
        return (false, 0)
    }
}
