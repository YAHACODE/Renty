//
//  ProductPageViewController.swift
//  Renty
//
//  Created by yahya on 7/29/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import MessageUI


class ProductPageViewController: UIViewController, MFMailComposeViewControllerDelegate{

    var paginatedScrollView: PaginatedScrollView?

    @IBOutlet weak var usernamelabel: UILabel!

    @IBOutlet weak var titleTextlabel: UILabel!
    
    
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var profileimageview: UIImageView!
    
    var image1:UIImage?
    var image2:UIImage?
    var image3:UIImage?
    
    //var user: PFUser?
    var user: User?

    
    
    
    
    @IBAction func launchEmail(sender: AnyObject) {
        var usermail  : NSString?

        usermail = self.post!.user?.email
        println(usermail)
        
        var emailTitle = "Rent product"
        var messageBody = "know everything about this item"
        var toRecipents = ["usermail"]
        var mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setMessageBody(messageBody, isHTML: false)
        mc.setToRecipients(toRecipents)
        
        self.presentViewController(mc, animated: true, completion: nil)
    }
    
    func mailComposeController(controller:MFMailComposeViewController, didFinishWithResult result:MFMailComposeResult, error:NSError) {
        switch result.value {
        case MFMailComposeResultCancelled.value:
            println("Mail cancelled")
        case MFMailComposeResultSaved.value:
            println("Mail saved")
        case MFMailComposeResultSent.value:
            println("Mail sent")
        case MFMailComposeResultFailed.value:
            println("Mail sent failure: %@", [error.localizedDescription])
        default:
            break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    @IBAction func unwindToProductPageView (segue : UIStoryboardSegue ) {

        
    }
    

   
    var post: Post?
    
    
    func displayPost( post: Post?) {
        if let post = post , titleTextlabel = titleTextlabel, descriptionLabel = descriptionLabel ,priceLabel = priceLabel, usernamelabel = usernamelabel   {
            
           
        
            profileimageview.image = user?.profileimage.value
            
            usernamelabel.text = self.post!.user?.username
            titleTextlabel.text = post.title as String
            descriptionLabel.text = post.productdescription as? String
            
            var stringg:NSNumber  = post.enteredprice!
            let price:String = String(format:"%i", stringg.integerValue)
            priceLabel.text = price + "$"
            
        }
    }
    
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.user = self.post!.user as? User

        self.profileimageview.layer.cornerRadius = self.profileimageview.frame.size.width / 2
        self.profileimageview.clipsToBounds = true

        println(post)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        displayPost(post)

        paginatedScrollView = PaginatedScrollView(frame: CGRectMake(0, 50, self.view.frame.size.width, 300))
        self.view.addSubview(paginatedScrollView!) // add to the
        
        let images: [UIImage] = [ (post!.image1.value)!,  (post!.image2.value)!, (post!.image3.value)!]
        
        self.paginatedScrollView?.images = images
    }

}
