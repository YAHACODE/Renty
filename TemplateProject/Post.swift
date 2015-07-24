//
//  Post.swift
//  Renty
//
//  Created by yahya on 7/23/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Foundation
import FBSDKCoreKit
import Parse
import ParseUI
import Bond

class Post : PFObject, PFSubclassing {
    
    @NSManaged var title: NSString?

    
    @NSManaged var imageFile: PFFile?


    @NSManaged var user: PFUser?
    
    
    // this property will store the UIImage that is displayed
    var image: Dynamic<UIImage?> = Dynamic(nil)

    var imageBond: Bond<UIImage?>!
    
    //MARK: Initialization
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
    
    override init () {
        super.init()
    }
    
    static func parseClassName() -> String {
        return "Post"
    }
    
    //MARK: Actions

    func uploadImage() {
        // Parse does not allow this to be set in the initializer - we set it before post gets saved
        user = PFUser.currentUser()
        // only allow this user to write, any other user can only read
        let ACL = PFACL(user: user!)
        ACL.setPublicReadAccess(true)
        self.ACL = ACL
        
        // when image is set, upload it to the server
        let imageData = UIImageJPEGRepresentation(image.value, 0.8)


        imageFile = PFFile(data: imageData)

        imageFile?.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
            self.saveInBackgroundWithBlock(ErrorHandling.errorHandlingCallback)
        })


    }
    
  
    
    
}