//
//  GoodsSpecsPickerDelegate.swift
//  Quote Assist
//
//  Created by Li Yin on 8/4/16.
//  Copyright © 2016 Li Yin. All rights reserved.
//

import Foundation
import UIKit

extension MoreInfoViewController{
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
        case 0: return Constant().widthUnitArray.count
            
        case 1: return Constant().weightUnitArray.count
            
        default:
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return goodsWeightPicker.bounds.width
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView.tag {
        case 0: return Constant().widthUnitArray[row]
            
        case 1: return Constant().weightUnitArray[row]
            
        default:
            return nil
        }
    }
    
    //Implemente this function to refresh inputView
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView.tag {
        case 0: widthUnitChanged()
            
        case 1: weightUnitChanged()
            
        default:
            break
        }
    }
    
    func widthUnitChanged(){
        print("widthUnit changed")
        storeAllProvidedInfo()
        let selectedWidthUnit = Constant().widthUnitArray[goodsWidthPicker.selectedRowInComponent(0)]
        }
    
    func weightUnitChanged(){
        print("weightUnit changed")
        storeAllProvidedInfo()
        let selectedWeightUnit = Constant().weightUnitArray[goodsWeightPicker.selectedRowInComponent(0)]
    }
}
    

    
