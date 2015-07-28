//
//  loginpageViewController.swift
//  Renty
//
//  Created by yahya on 7/28/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Foundation
import UIKit
import Parse

class loginpageViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var usernameTextField : UITextField!
    @IBOutlet var passwordTextField : UITextField!
    @IBOutlet var invalidCreds : UILabel!
    @IBOutlet var missingUsername : UILabel!
    @IBOutlet var missingPassword : UILabel!
    
    
//    @IBAction func signUp(sender : AnyObject) {
//        
//    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        invalidCreds.hidden = true
        missingPassword.hidden = true
        missingUsername.hidden = true
        textFieldShouldReturn(usernameTextField)
        textFieldShouldReturn(passwordTextField)
    }
    
    
    
    @IBAction func login(sender : AnyObject) {
        var userCreds = usernameTextField.text
        var passCreds = passwordTextField.text
        var getUser = PFQuery(className:"_User")
        //        var queryForUser : PFQuery = PFUser .query()
        //        var usernamee = [queryForUser .getObjectWithId("FullName")]
        var getUserName = getUser.getObjectWithId("username")
        var getUserPass = getUser.getObjectWithId("password")
        var getAuthentication = getUser.getObjectWithId("Authenticated")
        var user : PFUser
        PFUser.logInWithUsernameInBackground(userCreds, password: passCreds) {
            (user ,error) -> Void in
            if user != nil {
                self.performSegueWithIdentifier("loginViewSegue", sender: self)
                user?.save()
                
            }
            else if  self.usernameTextField.text != "" && self.passwordTextField.text != "" {
                //checking username validity
                
                if userCreds != getUserName && passCreds == getUserPass && getAuthentication == false {
                    self.missingUsername.hidden = true
                    self.missingPassword.hidden = true
                    self.invalidCreds.hidden = false
                }
                else if userCreds == getUserName && passCreds != getUserPass {
                    self.invalidCreds.hidden = false
                    self.missingUsername.hidden = true
                    self.missingPassword.hidden = true
                }
                else {
                    self.invalidCreds.hidden = false
                    self.missingUsername.hidden = true
                    self.missingPassword.hidden = true
                }
                /////////////////////
            }
            else if self.usernameTextField.text == "" && self.passwordTextField.text != "" {
                self.missingUsername.hidden = false
                self.missingPassword.hidden = true
                self.invalidCreds.hidden = true
                
            }
            else if  self.usernameTextField.text != "" && self.passwordTextField.text == "" {
                self.missingPassword.hidden = false
                self.missingUsername.hidden = true
                self.invalidCreds.hidden = true
                
            }
            else  {
                
                self.missingUsername.hidden = false
                self.missingPassword.hidden = false
                self.invalidCreds.hidden = true
            }
            
            
            
            
        }
        
    }
}
