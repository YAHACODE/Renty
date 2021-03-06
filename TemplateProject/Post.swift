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
import ConvenienceKit

class Post : PFObject, PFSubclassing {
   @NSManaged var title: NSString
   @NSManaged var productdescription: NSString?
   @NSManaged var tag: NSString?
   @NSManaged var periode: NSString?
   @NSManaged var enteredprice: NSNumber?
   @NSManaged var postlocation: PFGeoPoint?
   @NSManaged var imageFile: PFFile?
   @NSManaged var imageFile2: PFFile?
   @NSManaged var imageFile3: PFFile?
   @NSManaged var user: PFUser?
    // this property will store the UIImage that is displayed
    var image1: Dynamic<UIImage?> = Dynamic(nil)
    var image2: Dynamic<UIImage?> = Dynamic(nil)
    var image3: Dynamic<UIImage?> = Dynamic(nil)
    var photoUploadTask: UIBackgroundTaskIdentifier?
    var imageBond: Bond
    static var imageCache: NSCacheSwift<String, UIImage>!
    //MARK: Initialization
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
            // 1
            Post.imageCache = NSCacheSwift<String, UIImage>()
        }
    }
    override init () {
        super.init()
    }
    static func parseClassName() -> String {
        return "Post"
    }
    //MARK: Actions
    func downloadImage() {
        image1.value = Post.imageCache[self.imageFile!.name]
        image2.value = Post.imageCache[self.imageFile2!.name]
        image3.value = Post.imageCache[self.imageFile3!.name]
        if (image1.value == nil) {
            imageFile?.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
                if let data = data {
                    let image1 = UIImage(data: data, scale:1.0)!
                    self.image1.value = image1
                    Post.imageCache[self.imageFile!.name] = image1
                }
            }
        }
        if (image2.value == nil) {
            imageFile2?.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
                if let data = data {
                    let image2 = UIImage(data: data, scale:1.0)!
                    self.image2.value = image2
                    Post.imageCache[self.imageFile2!.name] = image2
                }
            }
        }
        if (image3.value == nil) {
            imageFile3?.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
                if let data = data {
                    let image3 = UIImage(data: data, scale:1.0)!
                    self.image3.value = image3
                    Post.imageCache[self.imageFile3!.name] = image3
                }
            }
        }
    }
    func uploadPost() {
        user = PFUser.currentUser()
        let ACL = PFACL(user: user!)
        ACL.setPublicReadAccess(true)
        self.ACL = ACL
        let location = PFGeoPoint?(postlocation!)
        let Userlocation = PFGeoPoint?(location!)
        let text = NSString?(title)
        let Title = NSString?(text!)
        let description = NSString?(productdescription!)
        let Productdescription = NSString?(description!)
        let tags = NSString?(tag!)
        let itemtag = NSString?(tags!)
        let period = NSString?(periode!)
        let periodfield = NSString?(period!)
        let price = NSNumber?(enteredprice!)
        let Enteredprice = NSNumber?(price!)
        let imageData = UIImageJPEGRepresentation(image1.value, 0.8)
        let imageData2 = UIImageJPEGRepresentation(image2.value, 0.8)
        let imageData3 = UIImageJPEGRepresentation(image3.value, 0.8)
        let imageFile = PFFile(data: imageData)
        let imageFile2 = PFFile(data: imageData2)
        let imageFile3 = PFFile(data: imageData3)
        user = PFUser.currentUser()
        self.postlocation = Userlocation!
        self.periode = periodfield!
        self.title = Title!
        self.enteredprice = Enteredprice!
        self.productdescription = Productdescription
        self.imageFile = imageFile
        self.imageFile2 = imageFile2
        self.imageFile3 = imageFile3
        self.tag = itemtag
        photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () -> Void in
            UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
        }
        saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                ErrorHandling.defaultErrorHandler(error)
            }
            self.saveInBackgroundWithBlock(nil)

            UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
        }
    
    }
 }

  
    
    
