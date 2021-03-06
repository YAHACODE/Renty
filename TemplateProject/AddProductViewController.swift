//
//  AddProductViewController.swift
//  Renty
//
//  Created by yahya on 7/22/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//


import UIKit
import Foundation
import FBSDKCoreKit
import Parse
import ParseUI
import Bond



class AddProductViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UITextViewDelegate {
    
var products = ["Fashion", "Home and decor", "Electronics", "Baby and kids" , "Collectibles and Art", "Sporting Goods","Automobile", "other stuff"]

    @IBOutlet weak var missingField: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    
    
    var kbHeight : CGFloat!
    
    @IBOutlet weak var dolarlabel: UILabel!
    @NSManaged var imageFile: PFFile?
    @NSManaged var imageFile2: PFFile?
    @NSManaged var imageFile3: PFFile?

   // @IBOutlet weak var DescriptionTextField: UITextField!
    
    @IBOutlet weak var PriceTextField: UITextField!

    @IBOutlet weak var DescriptionTextField: UITextView!
    
    @IBOutlet weak var DescriptionTextField2: UITextField!
    @IBOutlet weak var periodField: UITextField!
    @IBOutlet weak var capturedImage: UIImageView!
    @IBOutlet weak var capturedImage2: UIImageView!
    @IBOutlet weak var capturedImage3: UIImageView!
    
    var image1:UIImage?
    var image2:UIImage?
    var image3:UIImage?

    var itemselected : String = ""
    
    

    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
    
    return 1
        
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
     
        return products.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!{
        

        return products[row]
    }
   
     func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        let itemselected = products[row]
        
        self.itemselected = itemselected
        
        
    }
    
    
    
    @IBAction func add(sender: UIButton) {
      
     
        
        //input data
        var title = titleTextField?.text
        var productdescription = DescriptionTextField?.text
        var enteredprice = Int(PriceTextField?.text)
        var tag = self.itemselected
        
        var periode = periodField?.text

        
        print(tag)

        print(enteredprice)

       
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (userlocation: PFGeoPoint?, error: NSError?) -> Void in
            if error == nil {
                if self.titleTextField.text == "" || self.DescriptionTextField.text == "" || self.PriceTextField.text == "" || self.capturedImage.image == nil || self.capturedImage2.image == nil || self.capturedImage3.image == nil {
                    
                    self.missingField.hidden = false
                    
                }
                else {
                    self.performSegueWithIdentifier("timeline", sender: self)
                    
                    let post = Post()
                    
                    post.periode = periode
                    post.postlocation = userlocation
                    post.tag = tag
                    post.title = title!
                    post.enteredprice = enteredprice!
                    post.productdescription = productdescription!
                    post.image1.value = self.image1!
                    post.image2.value = self.image2!
                    post.image3.value = self.image3!

                    post.uploadPost()
                }
               
         
            }
            
        }
    }


    override func viewDidLoad() {
        
        
        PriceTextField.attributedPlaceholder = NSAttributedString(string:"Price",
            attributes:[NSForegroundColorAttributeName: UIColor.blackColor()])
        titleTextField.attributedPlaceholder = NSAttributedString(string:"Title",
            attributes:[NSForegroundColorAttributeName: UIColor.blackColor()])
        
//        dolarlabel.attributedPlaceholder = NSAttributedString(string:"$",
//            attributes:[NSForegroundColorAttributeName: UIColor.blackColor()])

        
           dolarlabel.text = "$"
           dolarlabel.textColor =  UIColor.blackColor()
        
           DescriptionTextField?.text = "Description"
           DescriptionTextField?.textColor = UIColor.blackColor()

            periodField.attributedPlaceholder = NSAttributedString(string:"month hour or day",
            attributes:[NSForegroundColorAttributeName: UIColor.blackColor()])
        
    missingField.hidden = true
        
        super.viewDidLoad()
        capturedImage.image = image1
        capturedImage2.image = image2
        capturedImage3.image = image3
        
        let borderColor = UIColor(red: 174.0/255.0, green: 174.0/255.0, blue: 174.0/255.0, alpha: 1.0)
        capturedImage.setBorder(13, width: 1, color: borderColor)
        capturedImage2.setBorder(13, width: 1, color: borderColor)
        capturedImage3.setBorder(13, width: 1, color: borderColor)
   
//        textfieldreturn(titleTextField)
//        textfieldreturn(PriceTextField)
       
        titleTextField.delegate = self
        PriceTextField.delegate = self
        periodField.delegate = self
        
        textFieldShouldReturn(titleTextField)
        textFieldShouldReturn(PriceTextField)
        textFieldShouldReturn(periodField)
        textFieldShouldReturn(DescriptionTextField2)
    }
    
    func textFieldShouldReturn(textField: UITextField ) -> Bool {
        textField.resignFirstResponder()
        titleTextField.resignFirstResponder()

        return true
    }
    

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                kbHeight = keyboardSize.height - 50.0
                self.animateTextField(true)
            }
        }
    }
    
    
    func keyboardWillHide(notification: NSNotification) {
        self.animateTextField(false)
    }
    
    func animateTextField(up: Bool) {
        let movement = (up ? -kbHeight : kbHeight)
        UIView.animateWithDuration(0.3, animations: {
            self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        })
    }
    
    
    
    func textfieldreturn(textfield : UITextField) {
        textfield.delegate = self
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
   
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension UIView {
    func setBorder(radius:CGFloat, width:CGFloat, color:UIColor) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        self.layer.borderColor = color.CGColor
        self.layer.borderWidth = width
    }
}
