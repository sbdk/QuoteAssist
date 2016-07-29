//
//  InputViewController.swift
//  Quote Assist
//
//  Created by Li Yin on 7/28/16.
//  Copyright © 2016 Li Yin. All rights reserved.
//

import UIKit
import Foundation

class InputViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var inputCurrencyPicker: UIPickerView!
    @IBOutlet weak var inputShippingTermPicker: UIPickerView!
    @IBOutlet weak var inputPriceUnitPicker: UIPickerView!

    @IBOutlet weak var outputShippingTermPicker: UIPickerView!
    @IBOutlet weak var outputCurrencyPicker: UIPickerView!
    @IBOutlet weak var outputPriceUnitPicker: UIPickerView!
    
    @IBOutlet weak var priceInputTextField: UITextField!
    @IBOutlet weak var inputDoneButton: UIButton!
    
    @IBOutlet weak var inputBackgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputCurrencyPicker.delegate = self
        inputShippingTermPicker.delegate = self
        inputPriceUnitPicker.delegate = self
        
        outputShippingTermPicker.delegate = self
        outputCurrencyPicker.delegate = self
        outputPriceUnitPicker.delegate = self
        
        priceInputTextField.delegate = self
        priceInputTextField.keyboardType = .DecimalPad
        
        inputDoneButton.backgroundColor = UIColor.orangeColor()
        inputDoneButton.layer.cornerRadius = 30.0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        inputDoneButton.alpha = 0
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.2, animations: {
        self.inputDoneButton.alpha = 1
        })
    }
    
    @IBAction func priceInputDone(sender: AnyObject) {
        view.endEditing(true)
        UIView.animateWithDuration(0.2, animations: {
            self.inputDoneButton.alpha = 0
        })
    }
}
