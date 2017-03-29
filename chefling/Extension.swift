//
//  File.swift
//  chefling
//
//  Created by Sanjay Mali on 29/03/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import Foundation
import UIKit
extension RecipeViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerRecipeType{
            print("RecipeType")
            return rType.count
            
        }else if pickerView == pickerViewServers
        {
            print("pickerServes")
            return pickerServes.count
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerRecipeType{
            return "\(rType[row])"
        }else if pickerView == pickerViewServers{
            return pickerServes[row]
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerRecipeType{
            recipeType.text = "\(rType[row])"
            self.pickerRecipeType.reloadAllComponents()
        }else if pickerView == pickerViewServers{
            servers.text = pickerServes[row]
            self.pickerViewServers.reloadAllComponents()
        }
    }    
}
