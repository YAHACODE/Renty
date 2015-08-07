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


class ProfilePageViewController: UIViewController,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate
 {
    var usernamename : String!
    
    var currentUser = PFUser.currentUser()
    var selectedCell: PostTableViewCell?

    @IBOutlet weak var username: UILabel!
    
    @IBOutlet  var Logoutbutton: UIButton!
    var users: [User] = []
    var timelineComponent: TimelineComponent<Post, TimelineViewController>!

    @IBOutlet weak var btnClickMe: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    var picker:UIImagePickerController?=UIImagePickerController()
    var popover:UIPopoverController?=nil
    
   // @NSManaged var Profilepicture : PFFile?

    @IBAction func logOut(sender : AnyObject) {
        
        PFUser.logOut()
        var currentUser = PFUser.currentUser()
        currentUser = nil
        
    }
    

    
    
    @IBOutlet weak var tableview: UITableView!
    var posts: [Post] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker!.delegate=self
        

        usernamename = currentUser?.username

        username.text = ("\(usernamename)")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        

        
        let user = User()
        
        let profileQuery = User.query()

     
        profileQuery!.whereKey("user", equalTo: PFUser.currentUser()!)

        
        
        profileQuery!.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            // 8
            self.users = result as? [User] ?? []
          
            for user in self.users {
            
            let data = user.Profilepicture?.getData()
            // 3
      
            user.image = UIImage(data: data!, scale:1.0)
            
          self.imageView.image = user.image
            
        }
        
//            self.tableview.reloadData()
        }
        
      
        dispatch_async(dispatch_get_main_queue(), { () ->  Void in
            
       
        
        let postsQuery = Post.query()
        
      postsQuery!.whereKey("user", equalTo: PFUser.currentUser()!)

      postsQuery!.orderByDescending("createdAt")

      postsQuery!.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            // 8
            self.posts = result as? [Post] ?? []
            // 9
            
            self.tableview.reloadData()
        }
             })
    }
    
    @IBAction func btnImagePickerClicked(sender: AnyObject)
    {
        var alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        var cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.openCamera()
                
        }
        var gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.openGallary()
        }
        var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel)
            {
                UIAlertAction in
                
        }
        
        // Add the actions
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
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        picker .dismissViewControllerAnimated(true, completion: nil)
        imageView.image=info[UIImagePickerControllerOriginalImage] as? UIImage
        ////yooo
       
        var profileimage:UIImage = imageView.image!
        

        
        let Profilepicture = PFFile(data: UIImageJPEGRepresentation(profileimage, 0.8))
        Profilepicture.save()

        
        let user = User()
//         let user = PFUser.currentUser()
        user.Profilepicture = Profilepicture
       // user = PFUser.currentUser()
        user.save()
        user.image = profileimage
        user.uploadImage()
       
    
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        println("picker cancel.")
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
        // 1
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 2
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
        
        
        let post = posts[indexPath.row]
        
        // cell.textLabel!.text = "Post"
        post.downloadImage()
        // 2
        cell.post = post
        return cell
    }
    
}



extension ProfilePageViewController: UITableViewDelegate {
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
//        selectedPost = posts[indexPath.row] //1
        selectedCell = tableView.cellForRowAtIndexPath(indexPath) as? PostTableViewCell
        
        self.performSegueWithIdentifier("ShowExistingPost", sender: self) //2
       // println(selectedPost)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
  
    
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        
//        timelineComponent.targetWillDisplayEntry(indexPath.row)
//    }
    
   
  
  
    
}