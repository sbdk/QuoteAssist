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
    @IBOutlet weak var currencyFactorUSDTextField: UITextField!
    
    
    @IBOutlet weak var goodsWidthTextField: UITextField!
    @IBOutlet weak var goodsWeightTextField: UITextField!

    
    @IBOutlet weak var shippingQtyUnit: UILabel!
    @IBOutlet weak var baseCurrency: UILabel!
    @IBOutlet weak var resultCurrency: UILabel!
    @IBOutlet weak var resultCurrencyForUSD: UILabel!


    @IBOutlet weak var goodsWidthPicker: UIPickerView!
    @IBOutlet weak var goodsWeightPicker: UIPickerView!
    
    var inputPriceUnit: String!
    var outputCurrency: String!
    var inputCurrency: String!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        //Set picker views delegate
        goodsWidthPicker.delegate = self
        goodsWeightPicker.delegate = self
        
        //Set label's current text according to input & output dataPicker setting
        shippingQtyUnit.text = String(inputPriceUnit.characters.dropFirst())
        
        //Here base currency is the left side unit, 
        //resultCurrency is the right side unit
        
        /*In reality and most of the time, USD & EUR will be the output currency, most quotes are based on these currency. Meanwhile, USD & EUR are stronger currency than others, makes them sutiable for a base currency in currency convert*/
        
        baseCurrency.text = outputCurrency
        resultCurrency.text = inputCurrency
        resultCurrencyForUSD.text = inputCurrency
        
        //Set pickerView's selected value according to most recent stored record
        let widthIndex = Constant().widthUnitArray.indexOf(appDelegate.goodsSpecsInfo["widthUnit"]!) ?? 0
        let weightIndex = Constant().weightUnitArray.indexOf(appDelegate.goodsSpecsInfo["weightUnit"]!) ?? 0
        goodsWidthPicker.selectRow(widthIndex, inComponent: 0, animated: true)
        goodsWeightPicker.selectRow(weightIndex, inComponent: 0, animated: true)
        
        //Retrive stored data and set all textField text
        shippingCostTextField.text = String(appDelegate.totalShippingCost)
        shippingQtyTextField.text = String(appDelegate.totalShippingQty)
        currencyFactorTextField.text = appDelegate.currencyFactor["factor"]
        currencyFactorUSDTextField.text = appDelegate.currencyFactorUSD["factor"]
        goodsWidthTextField.text = appDelegate.goodsSpecsInfo["width"]
        goodsWeightTextField.text = appDelegate.goodsSpecsInfo["weight"]
        
        //Set all textField delegate and keyboard type
        let textFieldSet: Set<UITextField> = [shippingCostTextField, shippingQtyTextField, currencyFactorTextField, currencyFactorUSDTextField, goodsWidthTextField, goodsWeightTextField]
        configTextFields(textFieldSet)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //If output currency it other than USD,
    //user need to provide USD cureency factor as well
    //Since gloabl shipping cost are based in USD
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 1 where self.outputCurrency == "USD":
            return 1
        default:
            return 2
        }
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
            textField.textAlignment = .Center
            textField.clearsOnBeginEditing = true
            textField.inputAccessoryView = keyboardToolBar
            textField.layer.borderWidth = 1.0
            textField.layer.masksToBounds = true
            textField.layer.cornerRadius = 6.0
            textField.layer.borderColor = UIColor.lightGrayColor().CGColor
            
            if textField.doubleValue == 0 {
                textField.backgroundColor = UIColor.orangeColor()
            }
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
        
        //Store all textField info and goodsSpecsPicker info
        storeAllProvidedInfo()
    }
    
    func storeAllProvidedInfo(){
        
        // 1 - Store shipping cost as xx USD per input priceUnit
        //If user use "/M" as input priceUnit, unit shipping cost would be "xx" USD/M
        appDelegate.totalShippingCost = shippingCostTextField.doubleValue
        appDelegate.totalShippingQty = shippingQtyTextField.doubleValue
        if shippingQtyTextField.doubleValue != 0 {
            appDelegate.unitShippingCost = shippingCostTextField.doubleValue / shippingQtyTextField.doubleValue
            print("shipping cost is: \(appDelegate.unitShippingCost)")
        } else {
//            UIView.animateWithDuration(2, animations: {
//                self.shippingQtyTextField.backgroundColor = UIColor.orangeColor()
//            })
        }

        // 2 - Store currencyFactor info
        appDelegate.currencyFactor["baseCurrency"] = baseCurrency.text!
        appDelegate.currencyFactor["resultCurrency"] = resultCurrency.text!
        appDelegate.currencyFactor["factor"] = currencyFactorTextField.text! ?? "0"
        appDelegate.currencyFactorUSD["resultCurrency"] = resultCurrencyForUSD.text! ?? ""
        appDelegate.currencyFactorUSD["factor"] = currencyFactorUSDTextField.text! ?? "0"
        
        // 3 - Store GoodsSpecs info
        appDelegate.goodsSpecsInfo["widthUnit"] = Constant().widthUnitArray[goodsWidthPicker.selectedRowInComponent(0)]
        appDelegate.goodsSpecsInfo["weightUnit"] = Constant().weightUnitArray[goodsWeightPicker.selectedRowInComponent(0)]
        appDelegate.goodsSpecsInfo["width"] = goodsWidthTextField.text! ?? "0"
        appDelegate.goodsSpecsInfo["weight"] = goodsWeightTextField.text! ?? "0"
    }

}

extension UITextField {
    var stringValue : String { return text                ?? "" }
    var integerValue: Int    { return Int(stringValue)    ?? 0  }
    var doubleValue : Double { return Double(stringValue) ?? 0.0  }
    var floatValue  : Float  { return Float(stringValue)  ?? 0.0  }
}
