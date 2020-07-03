//
//  ConverterController.swift
//  NumberConverter
//
//  Created by Saravia, Kevin on 7/2/20.
//  Copyright © 2020 Saravia, Kevin. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var scType: UISegmentedControl!
    @IBOutlet weak var tfNumber: UITextField!
    @IBOutlet weak var lbResult: UILabel!
    @IBOutlet weak var stNumber: UIStepper!
    @IBOutlet weak var pvConversion: UIPickerView!
    
    var stepper: Stepper!
    let conversions = ["Binary", "Decimal", "Hex", "Octal", "all four bases"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pvConversion.delegate = self
        self.pvConversion.dataSource = self
    }
    
    @IBAction func emptyNumber(_ sender: Any) {
        tfNumber.text = ""
    }
    
    @IBAction func updateStepper(_ sender: Any) {
        switch scType.selectedSegmentIndex {
        case 0:
            if let number = Double(tfNumber.text!) {
                stNumber.value = number
                lbResult.isHidden = true
                lbResult.backgroundColor = UIColor.green
            } else {
                errorMessage("decimal")
            }
        case 1:
            if let number = Int(tfNumber.text!, radix: 2) {
                stNumber.value = Double(number)
                lbResult.isHidden = true
                lbResult.backgroundColor = UIColor.green
            } else {
                errorMessage("binary")
            }
        case 2:
            if let number = Int(tfNumber.text!, radix: 0o10) {
                stNumber.value = Double(number)
                lbResult.isHidden = true
                lbResult.backgroundColor = UIColor.green
            } else {
                errorMessage("octal")
            }
        case 3:
            if let number = Int(tfNumber.text!, radix: 16) {
                stNumber.value = Double(number)
                lbResult.isHidden = true
                lbResult.backgroundColor = UIColor.green
            } else {
                errorMessage("hex")
            }
        default: break
        }
    }
    
    func errorMessage(_ type: String) {
        lbResult.isHidden = false
        lbResult.backgroundColor = UIColor.red
        lbResult.text = "Must follow \(type) format."
    }
    
    @IBAction func updateNumber(_ sender: UIStepper) {
        switch scType.selectedSegmentIndex {
        case 0:
            tfNumber.text = stNumber.value.description
        case 1:
            tfNumber.text = String(Int(stNumber.value), radix: 2)
        case 2:
            tfNumber.text = String(Int(stNumber.value), radix: 0o10)
        case 3:
            tfNumber.text = String(Int(stNumber.value), radix: 16)
        default: break
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return conversions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Display in \(conversions[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if lbResult.backgroundColor != UIColor.red {
            lbResult.text = ""
            lbResult.backgroundColor = UIColor.green
            switch row {
            case 0:
                lbResult.text! += "\(conversions[row]): \(String(Int(stNumber.value), radix: 2))\n"
            case 1:
                lbResult.text! += "\(conversions[row]): \(stNumber.value.description)\n"
            case 2:
                lbResult.text! += "\(conversions[row]): \(String(Int(stNumber.value), radix: 16))\n"
            case 3:
                lbResult.text! += "\(conversions[row]): \(String(Int(stNumber.value), radix: 0o10))\n"
            case 4:
                lbResult.text! += "Binary: \(String(Int(stNumber.value), radix: 2))\n"
                lbResult.text! += "Decimal: \(stNumber.value.description)\n"
                lbResult.text! += "Hex: \(String(Int(stNumber.value), radix: 16))\n"
                lbResult.text! += "Octal: \(String(Int(stNumber.value), radix: 0o10))\n"
            default: break
            }
            lbResult.isHidden = false
        }
    }

}
