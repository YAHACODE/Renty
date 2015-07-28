//
//  SignupViewController.swift
//  Renty
//
//  Created by yahya on 7/28/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Foundation
import UIKit
import Parse


class SignupViewController: UIViewController,UITextFieldDelegate {
  
    
    @IBOutlet var passwordTextField : UITextField!
    @IBOutlet var usernameTextField : UITextField!
    @IBOutlet var emailTextField : UITextField!
    @IBOutlet var fulLNameTextField : UITextField!
    @IBOutlet var usernameTaken : UILabel!
    @IBOutlet var emailTaken : UILabel!
    @IBOutlet var missingField : UILabel!
    @IBOutlet var invalidEmail : UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        usernameTextField.delegate = self
        emailTextField.delegate = self
        fulLNameTextField.delegate = self
        invalidEmail.hidden = true
        usernameTaken.hidden = true
        missingField.hidden = true
        emailTaken.hidden = true
        textFieldShouldReturn(passwordTextField)
        textFieldShouldReturn(emailTextField)
        textFieldShouldReturn(usernameTextField)
        textFieldShouldReturn(fulLNameTextField)
        
    }
    
    //    @IBAction func tappedOutside(sender : AnyObject) {
    //
    //        passwordTextField.resignFirstResponder()
    //        emailTextField.resignFirstResponder()
    //        usernameTextField.resignFirstResponder()
    //        fulLNameTextField.resignFirstResponder()
    //
    //    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func signUp(sender : AnyObject) {
        
        var userEntered = usernameTextField.text
        var passEntered = passwordTextField.text
        var emailEntered = emailTextField.text
        var fullNameEntered = fulLNameTextField.text
        var user = PFUser()
        user.username = userEntered
        user.password = passEntered
        user.email = emailEntered
        var savedUser = PFUser(className: "_User")
        
        func userSignUp() {
            
            [user .setObject(fullNameEntered, forKey: "FullName")]
            savedUser.setObject(userEntered, forKey: "username")
            savedUser.setObject(passEntered, forKey: "password")
            savedUser.setObject(fullNameEntered, forKey: "FullName")
            
            
            savedUser.saveInBackgroundWithBlock { (succeeded , error) -> Void in
                if error == nil {
                    println("saved!")
                }
                else {
                    
                }
            }
            
            
            user.signUpInBackgroundWithBlock {
                (succeeded ,error) -> Void in
                if error == nil {
                    println("user signed up")
                    self.performSegueWithIdentifier("signUpToLogIn", sender: self)
                    savedUser.setObject(user.isAuthenticated() == true, forKey: "authenticated")
                    savedUser.signUp()
                    
                    //   savedUser.save()
                    
                }
                else {
                    var errorcode = error!.code
                    
                    if (errorcode == 125 && errorcode == 202) {
                        self.invalidEmail.hidden = false
                        self.emailTaken.hidden = true
                        self.usernameTaken.hidden = false
                    }
                    else if (errorcode == 202 && errorcode == 203) {
                        self.invalidEmail.hidden = true
                        self.emailTaken.hidden = false
                        self.usernameTaken.hidden = false
                    }
                    else if errorcode == 125 {
                        self.invalidEmail.hidden = false
                        self.emailTaken.hidden = true
                        self.usernameTaken.hidden = true
                    }
                    else if errorcode == 202 {
                        self.invalidEmail.hidden = true
                        self.emailTaken.hidden = true
                        self.usernameTaken.hidden = false
                    }
                    else if errorcode == 203 {
                        self.invalidEmail.hidden = true
                        self.emailTaken.hidden = false
                        self.usernameTaken.hidden = true
                    }
                        
                    else {
                        
                    }
                    
                }
                
                
            }
        }
        
        
        if userEntered != "" && passEntered != "" && emailEntered != "" && fullNameEntered != ""  {
            missingField.hidden = true
            userSignUp()
            
        }
        else {
            missingField.hidden = false
        }
        
    }
    
}