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

    
    @NSManaged var username: NSString

    
    
    @IBOutlet weak var usernamelabel: UILabel!
    @IBOutlet weak var profileimage: UIImageView!
    
    @IBOutlet weak var titleTextlabel: UILabel!
    @IBOutlet weak var pricelabel: UILabel!
    @IBOutlet weak var postImageView1: UIImageView!
    
    var post:Post? {
        didSet {
            
            // free memory of image stored with post that is no longer displayed
            // 1
            if let oldValue = oldValue where oldValue != post {
                // 2
                postImageView1.designatedBond.unbindAll()


                if (oldValue.image1.bonds.count == 0) {
                    oldValue.image1.value = nil
                }

               
            }
            
            // 1
            if let post = post {
                
                //2
                // bind the image of the post to the 'postImage' view
                  post.image1 ->> postImageView1
            
                
            }
            
            
            
            
            
            
            
            self.getUser()
            self.updateUI()

 
        }
        
        

    }
    
    
    var user : User? {
        
        
        didSet{
        //query profile image
        // bind user prodile image to actual image in the cell
        
            self.updateUI()
            
            post!.image1 ->> profileimage

            
            
            
        
        }
    
    
    }

    
    func updateUI() {
        
        
        titleTextlabel.text = post!.title as String;
        
        var stringg:NSNumber  = post!.enteredprice!
        
        let price:String = String(format:"%i", stringg.integerValue)
        pricelabel.text = price + "$"
        
   self.usernamelabel.text = self.post!.user!.username
        

        
    }
    
    func getUser(){
      //query get user and assign to self.user
        //pass post.user instead of current user
        
   
        let userQuery = PFQuery(className: "User")
       // let userQuery = User.query()
      //  userQuery!.whereKey("user", equalTo: post!.user!)
        
        userQuery.whereKey("username", equalTo: post!.user!)

        userQuery.whereKey("Profilepicture", equalTo: post!.user!)

        userQuery.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
          
            
         //  self.user = result as? [User] ?? []
       // println()
            
            //println(self.post!.user?.username)
        }
    }
        
    }
    
    
        
    
