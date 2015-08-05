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
    
    var users: [User] = []

    @IBOutlet weak var profileimage: UIImageView!
    @IBOutlet weak var titleTextlabel: UILabel!
    @IBOutlet weak var pricelabel: UILabel!
    @IBOutlet weak var postImageView1: UIImageView!
//    @IBOutlet weak var postImageView2: UIImageView!
    
   // @IBOutlet weak var profileimageview: UIImageView!
    weak var timeline: TimelineViewController?
     var tagline: TagsPageViewController?
    
      var query = PFQuery(className: "Post")
    //var query = Post.query()

    
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
            
            
//         //   let user = User()
//            
//            let profileQuery = User.query()
//            
//            
//          //  profileQuery!.whereKey("user", equalTo: PFUser.currentUser()!)
//            
//            //query the user profile image related to that user post
//
//            
//            profileQuery!.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
//                // 8
//                self.users = result as? [User] ?? []
//                
//                for user in self.users {
//                    
//                    let data = user.Profilepicture?.getData()
//                    // 3
//                    
//                    user.image = UIImage(data: data!, scale:1.0)
//                    
//                    self.profileimage.image = user.image
//                    
//                }
//                
//                //            self.tableview.reloadData()
//            }
//            
            
            
            // 1
            if let post = post {
                
                //2
                // bind the image of the post to the 'postImage' view
                  post.image1 ->> postImageView1
            
                
             //   usernamelabel.text = post.user

              
           //    usernamelabel.text = post.user?.username
                
                
                titleTextlabel.text = post.title as String
 
                var stringg:NSNumber  = post.enteredprice!
              
                let price:String = String(format:"%i", stringg.integerValue)
                pricelabel.text = price + "$"
                
                
                //   post.image2 ->> postImageView2
               // post.pricelabel.text = theAlarmLabel
                
         
                
            }
            
            
        }
        
     

    }

    

    
    
    
    
    
}