//
//  User.swift
//  Renty
//
//  Created by yahya on 7/28/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Foundation
import FBSDKCoreKit
import Parse
import ParseUI
import Bond
import ConvenienceKit
class User : PFUser, PFSubclassing  {
    var photoUploadTask: UIBackgroundTaskIdentifier?
    var imageBond: Bond
    var profileimage: Dynamic<UIImage?> = Dynamic(nil)
    @NSManaged var Profilepicture: PFFile?
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
    class func User() -> String! {
        return "_User"
    }
    //MARK: Actions
    func uploadImage() {
        // Parse does not allow this to be set in the initializer - we set it before post gets saved
        // only allow this user to write, any other user can only read
        let ACL = PFACL(user: self)
        ACL.setPublicReadAccess(true)
        self.ACL = ACL
        // when image is set, upload it to the server
        let imageData = UIImageJPEGRepresentation(profileimage.value, 0.8)
        Profilepicture = PFFile(data: imageData)
        Profilepicture?.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
            self.saveInBackgroundWithBlock(ErrorHandling.errorHandlingCallback)
            self.setValue(self.Profilepicture, forKey: "Profilepicture")
            self.save()
            self.saveInBackgroundWithBlock(nil)
        })
    }
    
    func downloadProfileImage() {
        if (profileimage.value == nil) {
            Profilepicture?.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
                if let data = data {
                    let profileimage = UIImage(data: data, scale:1.0)!
                    self.profileimage.value = profileimage
                    Post.imageCache[self.Profilepicture!.name] = profileimage
                }
            }
        }
        
    }
}


