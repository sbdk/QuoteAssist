//
//  InputViewController.swift
//  Quote Assist
//
//  Created by Li Yin on 7/28/16.
//  Copyright © 2016 Li Yin. All rights reserved.
//

import UIKit
import Foundation


class InputViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate, UIPopoverPresentationControllerDelegate {
    //input picker views
    @IBOutlet weak var inputCurrencyPicker: UIPickerView!
    @IBOutlet weak var inputShippingTermPicker: UIPickerView!
    @IBOutlet weak var inputPriceUnitPicker: UIPickerView!

    //output picker views
    @IBOutlet weak var outputShippingTermPicker: UIPickerView!
    @IBOutlet weak var outputCurrencyPicker: UIPickerView!
    @IBOutlet weak var outputPriceUnitPicker: UIPickerView!
    
    //price input elements
    @IBOutlet weak var priceInputTextField: UITextField!
    @IBOutlet weak var inputDoneButton: UIButton!
    
    //input & output background view outlet
    @IBOutlet weak var inputBackgroundView: UIView!
    @IBOutlet weak var outputBackgroundView: UIView!
    
    //UIButtons
    @IBOutlet weak var moreInfoButton: UIButton!
    
    //Three status check lines
    @IBOutlet weak var statusLinesView: StatusLinesView!
    
    //View Object of StatusLinesView Class
    var linesView: StatusLinesView!
    
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
        moreInfoButton.layer.cornerRadius = 30.0
        
        addThreeLineView()
        linesView.addSubview(moreInfoButton)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        inputDoneButton.alpha = 0
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.2, animations: {
        self.inputDoneButton.alpha = 1
        self.outputBackgroundView.alpha = 0
        })
    }
    
    @IBAction func priceInputDone(sender: AnyObject) {
        view.endEditing(true)
        UIView.animateWithDuration(0.2, animations: {
            self.inputDoneButton.alpha = 0
            self.outputBackgroundView.alpha = 1
        })
    
    }
    
    
    @IBAction func moreInfoButtonTouched(sender: AnyObject) {
        
        
        let moreInfoViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MoreInfoTableView") as! MoreInfoViewController
        moreInfoViewController.inputPriceUnit = Constant().priceUnitArray[inputPriceUnitPicker.selectedRowInComponent(0)] ?? ""
        moreInfoViewController.inputCurrency = Constant().currencyArray[inputCurrencyPicker.selectedRowInComponent(0)] ?? ""
        moreInfoViewController.outputCurrency = Constant().currencyArray[outputCurrencyPicker.selectedRowInComponent(0)] ?? ""
        navigationController?.pushViewController(moreInfoViewController, animated: true)
        
     
    }
    
    func addThreeLineView() {
            
        // Initiate shippingTermLineView
        linesView = StatusLinesView(frame: self.statusLinesView.frame)
        
        view.addSubview(linesView)
        
        
                
        UIView.animateWithDuration(0.6, animations: {
            self.moreInfoButton.transform = CGAffineTransformMakeScale(1.5, 1.5)
            }, completion: { finish in
                UIView.animateWithDuration(0.6){
                    self.moreInfoButton.transform = CGAffineTransformIdentity
                }
        })

        // Animate the drawing of the line over the course of 2 second
        linesView.animateLine(2)
        
        
    }
    
}
