//
//  PostTableViewCell.swift
//  Renty
//
//  Created by yahya on 7/26/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import UIKit
import Bond
import Parse


class PostTableViewCell: UITableViewCell {

    
    @IBOutlet weak var usernamelabel: UILabel!
    @IBOutlet weak var profileimage: UIImageView!
    @IBOutlet weak var titleTextlabel: UILabel!
    @IBOutlet weak var pricelabel: UILabel!
    @IBOutlet weak var postImageView1: UIImageView!
    

    
    var post:Post? {
        didSet {

            // free memory of image stored with post that is no longer displayed
            if let oldValue = oldValue where oldValue != post {
                // 2
                postImageView1.designatedBond.unbindAll()
                if (oldValue.image1.bonds.count == 0) {
                    oldValue.image1.value = nil
                }

            }
            
            if let post = post {
           
                  post.image1 ->> postImageView1
            
                
            }
            
  
            self.getUser()
            self.updateUI()
            self.user = self.post!.user as? User
            
            
        }
        
        
        
    }
    
    
    
    var user : User? {
        
        didSet{
            if let oldValue = oldValue where oldValue != post {
                profileimage.designatedBond.unbindAll()
                
                if (oldValue.profileimage.bonds.count == 0) {
                    oldValue.profileimage.value = nil
                }
                
                
            }
            if let user = user {
                user.downloadProfileImage()

                user.profileimage ->> profileimage
                
                 
            }
        }
        
        
    }

    
    func updateUI() {
        
        
        titleTextlabel.text = post!.title as String;
        
        var stringg:NSNumber  = post!.enteredprice!
        
        let price:String = String(format:"%i", stringg.integerValue)
        pricelabel.text = price + "$"
        
        
//        var usernametext : String = self.post!.user!.username!
//        self.usernamelabel?.text = usernametext
        self.usernamelabel?.text = self.post!.user!.username
 
        
    }
    
    func getUser(){
        
        let userQuery = PFQuery(className: "_User")
        
        userQuery.whereKey("username", equalTo: post!.user!)
        
        userQuery.whereKey("Profilepicture", equalTo: post!.user!)
        
        userQuery.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            
            println(self.post!.user?.email)
            println(self.post!.user!.username)
            
            
        }
    }
    

    

    
    }


    
