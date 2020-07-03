//
//  Binary.swift
//  NumberConverter
//
//  Created by Saravia, Kevin on 7/3/20.
//  Copyright © 2020 Saravia, Kevin. All rights reserved.
//

import Foundation

class Binary
{
    // This class is just for casting between a String to a double for binaries.
    // Meant to be used by Converter class.
    
    func fromDouble(_ number: Double) -> String {
        return String(Int(number), radix: 2)
    }
    
    func toDouble(_ number: String) -> (check: Bool, result: Double) {
        if let convertedNum = Int(number, radix: 2) {
            return (true, Double(convertedNum))
        }
        return (false, 0)
    }
}
