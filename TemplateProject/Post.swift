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
   @NSManaged var productdescription: NSString?
   @NSManaged var enteredprice: NSNumber?

   @NSManaged var userlocation: PFGeoPoint?

    
    @NSManaged var imageFile: PFFile?
    @NSManaged var imageFile2: PFFile?
    @NSManaged var imageFile3: PFFile?


    @NSManaged var user: PFUser?
    
    
    // this property will store the UIImage that is displayed
    var image1: Dynamic<UIImage?> = Dynamic(nil)
    var image2: Dynamic<UIImage?> = Dynamic(nil)
    var image3: Dynamic<UIImage?> = Dynamic(nil)

    var photoUploadTask: UIBackgroundTaskIdentifier?

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

  
    
    func uploadPost() {
        
//        PFGeoPoint.geoPointForCurrentLocationInBackground {
//            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
//            if error == nil {
//                // do something with the new geoPoint
//            }
//        }
//        
        let location = PFGeoPoint?(userlocation!)
        let Userlocation = PFGeoPoint?(location!)
        
        let text = NSString?(title!)
        let Title = NSString?(text!)
        
        let description = NSString?(productdescription!)
        let Productdescription = NSString?(description!)

        
        let price = NSNumber?(enteredprice!)
        let Enteredprice = NSNumber?(price!)

        
        let imageData = UIImageJPEGRepresentation(image1.value, 0.8)
        let imageData2 = UIImageJPEGRepresentation(image2.value, 0.8)
        let imageData3 = UIImageJPEGRepresentation(image3.value, 0.8)

        let imageFile = PFFile(data: imageData)
        let imageFile2 = PFFile(data: imageData2)
        let imageFile3 = PFFile(data: imageData3)

        
        // any uploaded post should be associated with the current user
        user = PFUser.currentUser()
        self.userlocation = Userlocation!

        self.title = Title
        self.enteredprice = Enteredprice!
        self.productdescription = Productdescription

        self.imageFile = imageFile
        self.imageFile2 = imageFile2
        self.imageFile3 = imageFile3

        
        photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () -> Void in
            UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
        }
        
        saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                ErrorHandling.defaultErrorHandler(error)
            }
            
            UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
        }
    }
}

  
    
    
