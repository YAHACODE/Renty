//
//  ProfilePageViewController.swift
//  Renty
//
//  Created by yahya on 7/20/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//


import UIKit
import Parse
import ConvenienceKit
import AVFoundation
import Parse
import CoreImage
import Bond
class ProfilePageViewController: UIViewController,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate
 {
    @NSManaged var user: PFUser?
    var profileimage: Dynamic<UIImage?> = Dynamic(nil)
    @NSManaged var Profilepicture: PFFile?
    var currentUser = PFUser.currentUser()
    var selectedCell: PostTableViewCell?
    var usernamename : String!
    var users: [User] = []
    var posts: [Post] = []
    var timelineComponent: TimelineComponent<Post, TimelineViewController>!
    var popover:UIPopoverController?=nil
    var picker:UIImagePickerController?=UIImagePickerController()
    @IBOutlet weak var username: UILabel!
    @IBOutlet var Logoutbutton: UIButton!
    @IBOutlet weak var btnClickMe: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func logOut(sender : AnyObject) {
        PFUser.logOut()
        var currentUser = PFUser.currentUser()
        currentUser = nil
    }
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker!.delegate=self
        displayprofileusername()
    }
    func displayprofileusername(){
    usernamename = currentUser?.username
    username.text = ("\(usernamename)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        self.imageView.layer.borderWidth = 3.0
//        self.imageView.layer.borderColor = UIColor.whiteColor().CGColor
//        self.imageView.layer.cornerRadius = 10.0
        self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2
        self.imageView.clipsToBounds = true
        self.queryuserprofilepicture()
        self.queryuserpost()
    }
    func queryuserprofilepicture() {
        let user = User.currentUser()
        
//        if (profileimage.value == nil) {
//            // 2
//            Profilepicture?.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
//                if let data = data {
//                    let profileimage = UIImage(data: data, scale:1.0)!
//                    // 3
//                    self.profileimage.value = profileimage
//                    self.imageView.image = user!.profileimage.value
//
//                    
//                }
//            }
//        }
        
        // let user = User()
        let profileQuery = User.query()
        // profileQuery!.whereKey("user", equalTo: PFUser.currentUser()!)
        profileQuery!.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            self.users = result as? [User] ?? []
            for user in self.users {
                let data = user.Profilepicture?.getData()
                if data == nil {
                    print("no data")
                }
                else{
                    user.profileimage.value = UIImage(data: data!, scale:1.0)
                    self.imageView.image = user.profileimage.value
                }
            }
        }
    }
    func queryuserpost() {
       //dispatch_async(dispatch_get_main_queue(), { () ->  Void in
        let postsQuery = Post.query()
        postsQuery!.whereKey("user", equalTo: PFUser.currentUser()!)
        postsQuery!.orderByDescending("createdAt")
        postsQuery!.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
        self.posts = result as? [Post] ?? []
        self.tableview.reloadData()
        }
//       })
    }
        //ImagePickerClicked
    
    @IBAction func btnImagePickerClicked(sender: AnyObject)
    {
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel)
            {
                UIAlertAction in
        }
        picker?.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        // Present the controller
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone
        {
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            popover=UIPopoverController(contentViewController: alert)
            popover!.presentPopoverFromRect(btnClickMe.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        }
    }
    
    
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
            picker!.sourceType = UIImagePickerControllerSourceType.Camera
            self .presentViewController(picker!, animated: true, completion: nil)
        }
        else
        {
            openGallary()
        }
    }
    func openGallary()
    {
        picker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone
        {
            self.presentViewController(picker!, animated: true, completion: nil)
        }
        else
        {
            popover=UIPopoverController(contentViewController: picker!)
            popover!.presentPopoverFromRect(btnClickMe.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        picker .dismissViewControllerAnimated(true, completion: nil)
        imageView.image=info[UIImagePickerControllerOriginalImage] as? UIImage
        var profileimage:UIImage = imageView.image!
        let Profilepicture = PFFile(data: UIImageJPEGRepresentation(profileimage, 0.8))
        Profilepicture.save()
        let user = User.currentUser()
       //let user = User()
        user!.Profilepicture = Profilepicture
        user!.save()
        user!.profileimage.value = profileimage
        user!.uploadImage()
        
//        user!.query()
//        user!.profileimage.value?.description.lastPathComponent.join(<#elements: τ_0_0#>)
    
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        print("picker cancel.")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowExistingPost" {
            let postViewControler = segue.destinationViewController as! ProductPageViewController
            postViewControler.post = selectedCell!.post
            postViewControler.user = selectedCell!.user
        }
    }
}

extension ProfilePageViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
        let post = posts[indexPath.row]
        post.downloadImage()
        cell.post = post
        return cell
    }
}

extension ProfilePageViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedCell = tableView.cellForRowAtIndexPath(indexPath) as? PostTableViewCell
        self.performSegueWithIdentifier("ShowExistingPost", sender: self) //2
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}