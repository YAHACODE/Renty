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

    
    
    @IBOutlet weak var postImageView1: UIImageView!
    @IBOutlet weak var postImageView2: UIImageView!
    @IBOutlet weak var postImageView3: UIImageView!
    
    weak var timeline: TimelineViewController?

    
    var post:Post? {
        didSet {
            // 1
            if let post = post {
                //2
                // bind the image of the post to the 'postImage' view
                post.image1 ->> postImageView1
                post.image2 ->> postImageView2
                post.image3 ->> postImageView3

            }
        }
    }
    
    
    
    
}
