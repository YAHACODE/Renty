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
    
    var kbHeight: CGFloat!
    @IBOutlet var usernameTextField : UITextField!
    @IBOutlet var passwordTextField : UITextField!
    @IBOutlet var invalidCreds : UILabel!
    @IBOutlet var missingUsername : UILabel!
    @IBOutlet var missingPassword : UILabel!
    override func shouldAutorotate() -> Bool {
        return false
    }
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
                kbHeight = keyboardSize.height - 45.0
                self.animateTextField(true)
            }
        }
    }
    func keyboardWillHide(notification: NSNotification) {
        self.animateTextField(false)
    }
    
    func animateTextField(up: Bool) {
        var movement = (up ? -kbHeight : kbHeight)
        UIView.animateWithDuration(0.3, animations: {
            self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        })
    }
 
    
    override func viewDidLoad() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        invalidCreds.hidden = true
        missingPassword.hidden = true
        missingUsername.hidden = true
        textFieldShouldReturn(usernameTextField)
        textFieldShouldReturn(passwordTextField)
        usernameTextField.attributedPlaceholder = NSAttributedString(string:"what's your username",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        passwordTextField.attributedPlaceholder = NSAttributedString(string:"what's your password",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])

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
