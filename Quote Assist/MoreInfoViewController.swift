//
//  moreInfoViewController.swift
//  Quote Assist
//
//  Created by Li Yin on 7/29/16.
//  Copyright © 2016 Li Yin. All rights reserved.
//

import UIKit
import Foundation

class MoreInfoViewController: UITableViewController, UITextFieldDelegate, UIPickerViewDelegate {
    
    @IBOutlet weak var shippingCostTextField: UITextField!
    @IBOutlet weak var shippingQtyTextField: UITextField!
    @IBOutlet weak var currencyFactorTextField: UITextField!
    @IBOutlet weak var goodsWidthTextField: UITextField!
    @IBOutlet weak var goodsWeightTextField: UITextField!

    
    @IBOutlet weak var shippingQtyUnit: UILabel!
    @IBOutlet weak var baseCurrency: UILabel!
    @IBOutlet weak var resultCurrency: UILabel!

    @IBOutlet weak var goodsWidthPicker: UIPickerView!
    @IBOutlet weak var goodsWeightPicker: UIPickerView!

    
    var inputPriceUnit: String!
    var outputCurrency: String!
    var inputCurrency: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        shippingQtyUnit.text = String(inputPriceUnit.characters.dropFirst())
        baseCurrency.text = outputCurrency
        resultCurrency.text = inputCurrency
        
        //Set picker views delegate
        goodsWidthPicker.delegate = self
        goodsWeightPicker.delegate = self
        
        //Set all textField delegate and keyboard type
        let textFieldSet: Set<UITextField> = [shippingCostTextField, shippingQtyTextField, currencyFactorTextField, goodsWidthTextField, goodsWeightTextField]
        configTextFields(textFieldSet)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    //Help function for setup textField
    func configTextFields(textFieldSet:Set<UITextField>){
        
        //Config a custom keyboard accessoryView with toolBar
        //and a "Done" button to dismiss keyboard
        let keyboardToolBar = UIToolbar(frame: CGRectMake(0,0,50,50))
        let doneButton = UIBarButtonItem.init(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: #selector(MoreInfoViewController.dismissKeyboard))
        doneButton.tintColor = UIColor.redColor()
        
        let space1 = UIBarButtonItem.init(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let space2 = UIBarButtonItem.init(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        
        keyboardToolBar.items = [space1, doneButton, space2]
        
        for textField in textFieldSet{
            textField.delegate = self
            textField.keyboardType = .DecimalPad
            textField.inputAccessoryView = keyboardToolBar
        }
    }
    
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//
//        let invalidCharacters = NSCharacterSet(charactersInString: "0123456789").invertedSet
//        return string.rangeOfCharacterFromSet(invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
//    }
    
    @IBAction func exchangeCurrency(sender: AnyObject) {
        
        let currentBaseCurrency = baseCurrency.text
        let currentResultCurrency = resultCurrency.text
        baseCurrency.alpha = 0
        resultCurrency.alpha = 0
        
        UIView.animateWithDuration(1, animations: {
            self.baseCurrency.text = currentResultCurrency
            self.resultCurrency.text = currentBaseCurrency
            self.baseCurrency.alpha = 1.0
            self.resultCurrency.alpha = 1.0
        })
    }
    
    //Help funciton to dismiss keyboard
    func dismissKeyboard(){
        print("will dismiss keyboard now")
        view.endEditing(true)
    }
}
