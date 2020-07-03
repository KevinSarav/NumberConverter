//
//  ConverterController.swift
//  NumberConverter
//
//  Created by Saravia, Kevin on 7/2/20.
//  Copyright © 2020 Saravia, Kevin. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    // This view is for performing number conversions.
    
    @IBOutlet weak var scType: UISegmentedControl!
    @IBOutlet weak var tfNumber: UITextField!
    @IBOutlet weak var lbResult: UILabel!
    @IBOutlet weak var stNumber: UIStepper!
    @IBOutlet weak var pvConversion: UIPickerView!
    
    var converter: Converter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        converter = Converter()
        self.pvConversion.delegate = self
        self.pvConversion.dataSource = self
        tfNumber.keyboardType = UIKeyboardType.decimalPad
        self.tfNumber.delegate = self
        tfNumber.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tfNumber.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    @IBAction func changeType(_ sender: Any) {
        // Change keyboard type based on chosen number type
        switch scType.selectedSegmentIndex {
        case 0:
            tfNumber.keyboardType = UIKeyboardType.decimalPad
        case 1, 2:
            tfNumber.keyboardType = UIKeyboardType.numberPad
        case 3:
            tfNumber.keyboardType = UIKeyboardType.default
        default: break
        }
        // Convert value in text field to appropriate type
        let value = converter.getResult(scType.selectedSegmentIndex, stNumber.value)[0]
        tfNumber.text = value
        self.view.endEditing(true)
    }
    
    @IBAction func updateStepper(_ sender: Any) {
        // Update stepper value with user's new input in text field
        // If type can be casted to double based on chosen type:
        if converter.toDouble(scType.selectedSegmentIndex, tfNumber.text!).check {
            // Store casted double as the new stepper value and hide result label.
            let value = converter.toDouble(scType.selectedSegmentIndex, tfNumber.text!).result
            updateLimits(value)
            stNumber.value = value
            lbResult.isHidden = true
            lbResult.backgroundColor = UIColor.green
        } else {
            // Display error message because user input cannot be casted to double
            errorMessage("Must follow \(scType.titleForSegment(at: scType.selectedSegmentIndex)!) format.")
        }
    }
    
    func updateLimits(_ value: Double) {
        // Update maximum and minimum value for stepper when going out-of-bounds.
        // Range should always be 100
        if value > stNumber.maximumValue || value < stNumber.minimumValue {
            stNumber.maximumValue = value + 50
            stNumber.minimumValue = value - 50
        } else {
            // No limits are updated
        }
    }
    
    func errorMessage(_ message: String) {
        // Alter result label to display an error because of incorrect format
        lbResult.isHidden = false
        lbResult.backgroundColor = UIColor.red
        lbResult.text = message
    }
    
    @IBAction func updateNumber(_ sender: UIStepper) {
        // Increment / decrement text field number when using stepper
        // If the text field number isn't formatted incorrectly:
        if lbResult.backgroundColor != UIColor.red {
            // Convert updated double value in stepper to String and store in text field
            tfNumber.text = converter.toType(scType.selectedSegmentIndex, stNumber.value)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return converter.conversions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Display in \(converter.conversions[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Convert number based on chosen picker type and display it if there is not already an error message
        tfNumber.resignFirstResponder()
        self.pvConversion.delegate = self
        if lbResult.backgroundColor != UIColor.red {
            lbResult.text = ""
            lbResult.backgroundColor = UIColor.green
            lbResult.text = converter.toResult(row, stNumber.value)
            lbResult.isHidden = false
        }
    }

}
