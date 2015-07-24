//
//  AddProductViewController.swift
//  Renty
//
//  Created by yahya on 7/22/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import Bond


class AddProductViewController: UIViewController, UITextFieldDelegate  {
    

    
    @IBOutlet weak var titleTextField: UITextField!
    

    @IBOutlet weak var DescriptionTextField: UITextField!
 

    
    @IBOutlet weak var PriceTextField: UITextField!
    
    
    @IBOutlet weak var capturedImage: UIImageView!
    @IBOutlet weak var capturedImage2: UIImageView!
    @IBOutlet weak var capturedImage3: UIImageView!
    
    var image1:UIImage?
    var image2:UIImage?
    var image3:UIImage?
    
    func textfieldreturn(textfield : UITextField) {
        textfield.delegate = self
    }


    
    @IBAction func add(sender: UIButton) {
        
        //input data
        var title = titleTextField?.text
        var Description = DescriptionTextField?.text
        var enteredprice = PriceTextField?.text.toInt()
        
        
       // PFObject * items = [PFObject objectWithClassName:@"items"];

        let post4 = Post()
        
    // create an PFFile parse object
    // convert image to NSDATA *3
    // convert NSDATA to PFFile
    // add PFFile to the parse object 
    // parse.object["file1"]= file1
    //  parse object save in background !
        
       //upload image separately
        
//        let post = Post()
//        post.image.value = image1
//        post.uploadImage()
//        
//        let post2 = Post()
//        post2.image.value = image2
//        post2.uploadImage()
//        
//        let post3 = Post()
//        post3.image.value = image3
//        post3.uploadImage()
        
        
    }


    
    override func viewDidLoad() {
    
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
    


}


