//
//  Converter.swift
//  NumberConverter
//
//  Created by Saravia, Kevin on 7/2/20.
//  Copyright © 2020 Saravia, Kevin. All rights reserved.
//

import Foundation

class Converter
{
    // This class performs number conversions for Converter view.
    // This class uses functions from the number type classes to perform conversions.
    
    var decimal: Decimal!
    var binary: Binary!
    var hex: Hex!
    var octal: Octal!

    let conversions = ["Decimal", "Binary", "Octal", "Hex", "all four bases"]
    
    init() {
        binary = Binary()
        decimal = Decimal()
        octal = Octal()
        hex = Hex()
    }
    
    func toType(_ index: Int, _ number: Double) -> String
    {
        // Convert a double from stepper to a type to store into text field
        switch index {
        case 0:
            return decimal.fromDouble(number)
        case 1:
            return binary.fromDouble(number)
        case 2:
            return octal.fromDouble(number)
        case 3:
            return hex.fromDouble(number)
        default: return ""
        }
    }
    
    func toDouble(_ index: Int, _ number: String) -> (check: Bool, result: Double)
    {
        // Convert a type to a double to be stored in stepper
        switch index {
        case 0:
            if decimal.toDouble(number).check {
                return (true, decimal.toDouble(number).result)
            } else {
                return (false, 0)
            }
        case 1:
            if binary.toDouble(number).check {
                return (true, binary.toDouble(number).result)
            } else {
                return (false, 0)
            }
        case 2:
            if octal.toDouble(number).check {
                return (true, octal.toDouble(number).result)
            } else {
                return (false, 0)
            }
        case 3:
            if hex.toDouble(number).check {
                return (true, hex.toDouble(number).result)
            } else {
                return (false, 0)
            }
        default: return (false, 0)
        }
    }
    
    func toResult(_ row: Int, _ number: Double) -> String
    {
        // Add label(s) to the left indicating the base for the line
        let resultArray = getResult(row, number)
        var result = ""
        
        if row == 4 {
            for i in 0..<resultArray.count {
                result += "\(conversions[i]): \(resultArray[i])\n"
            }
        } else {
            result = "\(conversions[row]): \(resultArray[0])"
        }
        
        return result
    }
    
    func getResult(_ row: Int, _ number: Double) -> Array<String> {
        // Get just the conversion output from the picker
        var result = ["", "", "", ""]
        switch row {
        case 0:
            result[0] = "\(number.description)"
        case 1:
            result[0] = "\(String(Int(number), radix: 2))"
        case 2:
            result[0] = "\(String(Int(number), radix: 0o10))"
        case 3:
            result[0] = "\(String(Int(number), radix: 16))"
        case 4:
            result[0] = "\(number.description)"
            result[1] = "\(String(Int(number), radix: 2))"
            result[2] = "\(String(Int(number), radix: 0o10))"
            result[3] = "\(String(Int(number), radix: 16))"
        default: break
        }
        return result
    }

}
