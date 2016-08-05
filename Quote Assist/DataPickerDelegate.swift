//
//  CurrencyPickerDelegate.swift
//  Quote Assist
//
//  Created by Li Yin on 7/28/16.
//  Copyright © 2016 Li Yin. All rights reserved.
//

import Foundation
import UIKit

extension InputViewController{
    

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
        case 0: return Constant().shippingTermArray.count
            
        case 1: return Constant().currencyArray.count
            
        case 2: return Constant().priceUnitArray.count
            
        default:
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return inputCurrencyPicker.bounds.width
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView.tag {
        case 0: return Constant().shippingTermArray[row]
            
        case 1: return Constant().currencyArray[row]
            
        case 2: return Constant().priceUnitArray[row]
            
        default:
            return nil
        }
    }
    
    //Implemente this function to refresh inputView
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView.tag {
        case 0: shippingTermChanged()
            
        case 1: currencyChanged()
            
        case 2: priceUnitChanged()
            
        default:
            break
        }
    }
    
    func shippingTermChanged(){
        print("shippingterm changed")
        
        let inputShippingTerm = Constant().shippingTermArray[inputShippingTermPicker.selectedRowInComponent(0)]
        let outputShippingTerm = Constant().shippingTermArray[outputShippingTermPicker.selectedRowInComponent(0)]
        
        switch (inputShippingTerm, outputShippingTerm) {
            case ("FOB","FOB"):
            //No need for shipping cost, green light
            linesView.shippingTermLineLayer.strokeColor = UIColor.greenColor().CGColor
            
            //Need shipping cost
            case ("FOB","CIF"):
                if appDelegate.unitShippingCost != 0 {
                    
                } else {
                    print("no shipping cost provided, red line")
                    linesView.shippingTermLineLayer.strokeColor = UIColor.redColor().CGColor
                }
            //Need shipping cost
            case ("CIF","FOB"):
                if appDelegate.unitShippingCost != 0 {
                    
                } else {
                    print("no shipping cost provided, red line")
                    linesView.shippingTermLineLayer.strokeColor = UIColor.redColor().CGColor
            }
            case ("CIF","CIF"):
                linesView.shippingTermLineLayer.strokeColor = UIColor.greenColor().CGColor
            default:
                break
        }
    }
    
    func currencyChanged(){
        print("currency changed")
        
    }
    
    func priceUnitChanged(){
        print("price unit changed")
    }
}