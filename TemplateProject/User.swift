//
//  User.swift
//  Renty
//
//  Created by yahya on 7/28/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Bond
import Parse

class User : PFObject, PFSubclassing {
    var photoUploadTask: UIBackgroundTaskIdentifier?
    
    @NSManaged var Profilepicture: PFFile?
    @NSManaged var user: PFUser?
    
    
    // this property will store the UIImage that is displayed
    var image: UIImage?
    //var image: UIImage?
    
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
        return "User"
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
        let imageData = UIImageJPEGRepresentation(image!, 0.8)
        Profilepicture = PFFile(data: imageData)
        
        Profilepicture?.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
            self.saveInBackgroundWithBlock(ErrorHandling.errorHandlingCallback)
            self.user!.setValue(self.Profilepicture, forKey: "Profilepicture")
            self.user!.save()
        })
    }
      }


