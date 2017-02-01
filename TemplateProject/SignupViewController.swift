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


class SignupViewController: UIViewController, UITextFieldDelegate {
  
    
    @IBOutlet var passwordTextField : UITextField!
    @IBOutlet var usernameTextField : UITextField!
    @IBOutlet var emailTextField : UITextField!
    @IBOutlet var fulLNameTextField : UITextField!
    @IBOutlet var usernameTaken : UILabel!
    @IBOutlet var emailTaken : UILabel!
    @IBOutlet var missingField : UILabel!
    @IBOutlet var invalidEmail : UILabel!
    var kbHeight: CGFloat!
    @IBOutlet weak var border: UIView!
    
    override func viewDidLoad() {
        passwordTextField.delegate = self
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
        border.setBorder(20.0, width: 1.0, color: UIColor.whiteColor())
        fulLNameTextField.attributedPlaceholder = NSAttributedString(string:"what's your name",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        emailTextField.attributedPlaceholder = NSAttributedString(string:"what's your email",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        usernameTextField.attributedPlaceholder = NSAttributedString(string:"what's your username",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        passwordTextField.attributedPlaceholder = NSAttributedString(string:"what's your password",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        
    }
    

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                kbHeight = keyboardSize.height - 70.0
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
            savedUser.setObject(emailEntered, forKey: "email")
            savedUser.saveInBackgroundWithBlock { (succeeded , error) -> Void in
                if error == nil {
                    print("saved!")
                }
                else {
                }
            }
            
            user.signUpInBackgroundWithBlock {
                (succeeded ,error) -> Void in
                if error == nil {
                    print("user signed up")
                    self.performSegueWithIdentifier("signUpToLogIn", sender: self)
                    savedUser.setObject(user.isAuthenticated() == true, forKey: "authenticated")
                    savedUser.signUp()
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
