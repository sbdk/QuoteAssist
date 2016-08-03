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
        
        
        let moreInfoView = self.storyboard?.instantiateViewControllerWithIdentifier("MoreInfoTableView") as! MoreInfoViewController
        navigationController?.pushViewController(moreInfoView, animated: true)
     
    }
    
    func addThreeLineView() {
            
        // Initiate shippingTermLineView
        linesView = StatusLinesView(frame: self.statusLinesView.frame)
        
        view.addSubview(linesView)
        
        // Animate the drawing of the line over the course of 1 second
        linesView.animateLine(2)
    }
    
}
