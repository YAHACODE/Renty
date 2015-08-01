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


    @IBOutlet weak var titleTextlabel: UILabel!
    @IBOutlet weak var pricelabel: UILabel!
    @IBOutlet weak var postImageView1: UIImageView!
//    @IBOutlet weak var postImageView2: UIImageView!
    
    @IBOutlet weak var profileimageview: UIImageView!
    weak var timeline: TimelineViewController?
    var query = PFQuery(className: "Post")
    
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
                
                  titleTextlabel.text = post.title as String
 
                //   post.image2 ->> postImageView2
               // post.pricelabel.text = theAlarmLabel
                
                
                
            }
            
            
        }
    }

    
   
    
    
    
    
    
}