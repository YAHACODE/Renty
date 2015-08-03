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



class AddProductViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate  {
    
var products = ["Fashion", "Home and decor", "Electronics", "Baby and kids" , "Collectibles and Art", "Sporting Goods", "Sporting Goods", "Automobile", "other stuff"]

    @IBOutlet weak var missingField: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    
    @NSManaged var imageFile: PFFile?
    @NSManaged var imageFile2: PFFile?
    @NSManaged var imageFile3: PFFile?

    @IBOutlet weak var DescriptionTextField: UITextField!
    
    @IBOutlet weak var PriceTextField: UITextField!

    
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
        
        var itemselected = products[row]
        
        self.itemselected = itemselected
        
        
    }
    
    
    func textfieldreturn(textfield : UITextField) {
        textfield.delegate = self
    }


    
    @IBAction func add(sender: UIButton) {
        
        
        //input data
        var title = titleTextField?.text
        var productdescription = DescriptionTextField?.text
        var enteredprice = PriceTextField?.text.toInt()
        var tag = self.itemselected

        
        println(tag)

        println(enteredprice)

       
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (userlocation: PFGeoPoint?, error: NSError?) -> Void in
            if error == nil {
                let post = Post()
               
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
            
           else  {
                self.missingField.hidden = false
                println("shit ")
            }
       

        }

        
    }


    
    override func viewDidLoad() {
        

        
    missingField.hidden = true
        
        super.viewDidLoad()
        capturedImage.image = image1
        capturedImage2.image = image2
        capturedImage3.image = image3
   
        textfieldreturn(titleTextField)
        textfieldreturn(PriceTextField)
        textfieldreturn(DescriptionTextField)

        textFieldShouldReturn(titleTextField)
        textFieldShouldReturn(PriceTextField)
        textFieldShouldReturn(DescriptionTextField)

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
   
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
}


