//
//  ViewController.swift
//  chefling
//
//  Created by Sanjay Mali on 23/03/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class RecipeViewController: UIViewController{
    @IBOutlet weak var recipeName: MytextField!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var master: UIButton!
    @IBOutlet weak var sourschef: UIButton!
    @IBOutlet weak var  textField:UITextField?
    @IBOutlet weak var beginner: UIButton!
    var selectedImag:UIImage?
    var data:NSData?
    var date_start:Date?
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var recipe_Image:UIImageView!
    @IBOutlet weak var cookingTime: MytextField!
    @IBOutlet weak var noteTextView: MyTextView!
    @IBOutlet weak var servers: MytextField!
    @IBOutlet weak var recipeType: MytextField!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var setRecipeImage: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let pickerViewServers = UIPickerView()
    let pickerViewCookingTime = UIDatePicker()
    let pickerRecipeType = UIPickerView()
    let timePickerView = TimePickerView()
    var pickerServes = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]
    let muteForPickerData = ["minute(s)","hour(s)"]
    let hours = Array(1...24)
    let minutes = Array(0...59)
    var rType = [JSON]()
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViewConfig()
        servers_Config_picker()
        cooking_Config_picker()
        recipeTypeConfig_picker()
    }
    func pickerViewConfig(){
        loadRecipeType()
        imagePicker.delegate = self
        recipeName.delegate = self
        recipeType.delegate = self
        servers.delegate = self
        cookingTime.delegate = self
        noteTextView.delegate = self
        pickerViewServers.dataSource = self
        pickerViewServers.delegate = self
        pickerRecipeType.dataSource = self
        pickerRecipeType.delegate  = self
        recipe_Image.clipsToBounds = true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func loadRecipeType(){
        let api = "http://www.chefling.me/testapi/getRecipeType.php"
        let param = ["RTid":"0"]
        Alamofire.request(api, method: .post, parameters: param, encoding: JSONEncoding.default).responseJSON {response in
            guard response.result.error == nil else {
                print(response.result.error!)
                return
            }
            if let json = response.data {
                let json_Data = JSON(data:json)
                for (key,subJson):(String, JSON) in json_Data{
                    //Do something you want
                    self.rType.append(subJson)
                }
            }
            self.pickerRecipeType.reloadAllComponents()
        }
    }
    @IBAction func setRecipeImageAction(_ sender: Any) {
        selectPhotos()
    }
    func selectPhotos(){
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        imagePicker.modalPresentationStyle = .popover
        present(imagePicker, animated: true, completion: nil)
    }
    func servers_Config_picker()
    {
        servers.inputView = pickerViewServers
        let toolBar = UIToolbar()
//        toolBar.barStyle = UIBarStyle.default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(hex:"85bb38")
        toolBar.barStyle = UIBarStyle.blackOpaque
        toolBar.backgroundColor = UIColor(hex:"85bb38")
        //        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.white
        toolBar.sizeToFit()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(RecipeViewController.server_done))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(RecipeViewController.server_cancel))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        servers.inputAccessoryView = toolBar
    }
    
    func server_done(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        self.view.endEditing(true)
        servers.resignFirstResponder()
    }
    func server_cancel(){
        self.view.endEditing(true)
        servers.resignFirstResponder()
    }
    
    
    func recipeTypeConfig_picker()
    {
        recipeType.inputView = pickerRecipeType
        let toolBar = UIToolbar()
//        toolBar.barStyle = UIBarStyle.default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(hex:"85bb38")
        toolBar.barStyle = UIBarStyle.blackOpaque
        toolBar.backgroundColor = UIColor(hex:"85bb38")
        //        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.white
        toolBar.sizeToFit()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(RecipeViewController.recipeType_done))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(RecipeViewController.recipeType_cancel))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        recipeType.inputAccessoryView = toolBar
    }
    
    func recipeType_done(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        self.view.endEditing(true)
        recipeType.resignFirstResponder()
    }
    func recipeType_cancel(){
        self.view.endEditing(true)
        recipeType.resignFirstResponder()
        
    }
    func cooking_Config_picker()
    {
        cookingTime.inputView = timePickerView
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.blackOpaque
        toolBar.backgroundColor = UIColor(hex:"85bb38")
//        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.white
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(RecipeViewController.cooking_done))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(RecipeViewController.cooking_cancel))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        cookingTime.inputAccessoryView = toolBar
    }
    func cooking_done(){
        self.cookingTime.text = "\(timePickerView.hour)"
        cookingTime.resignFirstResponder()
        self.view.endEditing(true)
    }
    func cooking_cancel(){
        cookingTime.resignFirstResponder()
        self.view.endEditing(true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
extension RecipeViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            recipe_Image.image = image
            self.selectedImag = image
            let data = UIImagePNGRepresentation(self.selectedImag!) as NSData?
            self.data = data
            recipe_Image.contentMode = .scaleAspectFill
            blurView.alpha = 0
        } else{
            print("Something went wrong")
            blurView.alpha = 1
        }
        self.dismiss(animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        animateViewMoving(up: false, moveValue: 100)
        textView.resignFirstResponder()
    }
    func textViewDidBeginEditing(_ textView: UITextView){
        if (textView.text == "" && textView.text.characters.count == 0) {
            noteTextView.text = "Notes, tell us the story behind it."
            textView.textColor = UIColor.lightGray
        }
        animateViewMoving(up: true, moveValue: 100)
        textView.becomeFirstResponder()
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(up: true, moveValue: 100)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false, moveValue: 100)
    }
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
}

