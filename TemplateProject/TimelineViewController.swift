//
//  TimelineViewController.swift
//  Renty
//
//  Created by yahya on 7/20/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import ConvenienceKit
import Bond


class TimelineViewController: UIViewController {
    
    var manager: OneShotLocationManager?
    var posts: [Post] = []

    var userlocation: PFGeoPoint?

    
    @IBOutlet weak var tableView: UITableView!

//        var image1: Dynamic<UIImage?> = Dynamic(nil)
//        var image2: Dynamic<UIImage?> = Dynamic(nil)
//        var image3: Dynamic<UIImage?> = Dynamic(nil)
//    
    
    override func viewDidLoad() {
       
        self.getusercurrentlocation()
        
        super.viewDidLoad()
        
       // self.tabBarController?.delegate = self
        manager = OneShotLocationManager()
        manager!.fetchWithCompletion {location, error in
            // fetch location or an error
            if let loc = location {
                
                //println(location)
            } else if let err = error {
               // println(err.localizedDescription)
            }
        }

        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    func getusercurrentlocation() {
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (userlocation: PFGeoPoint?, error: NSError?) -> Void in
            if error == nil {
                //                var geoPointLong = userlocation!.longitude
                //                var geoPointLat = userlocation!.latitude
                //                var currentLocation = PFGeoPoint(latitude: geoPointLat, longitude: geoPointLong)
                
                self.userlocation = userlocation
                
                println(userlocation)
                
                
            }
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        /*/ 1
//        let followingQuery = PFQuery(className: "Follow")
//        followingQuery.whereKey("fromUser", equalTo:PFUser.currentUser()!)
//        
//        // 2
//        let postsFromFollowedUsers = Post.query()
//        postsFromFollowedUsers!.whereKey("user", matchesKey: "toUser", inQuery: followingQuery)
//        
//        // 3
//        let postsFromThisUser = Post.query()
//        postsFromThisUser!.whereKey("user", equalTo: PFUser.currentUser()!)
//        
//        // 4
//        let query = PFQuery.orQueryWithSubqueries([postsFromFollowedUsers!, postsFromThisUser!])
//        // 5
//        query.includeKey("user")
//        // 6
//        query.orderByDescending("createdAt")
//        
//        // 7*/
//        
//        
//        
//        let postsQuery = Post.query()
//        
//        postsQuery!.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
//           
//            self.posts = result as? [Post] ?? []
//            for post in self.posts {
//                // 2
//                let data = post.imageFile?.getData()
//                // 3
//              
//                if let image1 = UIImage(data:data!) {
//                    dispatch_async(dispatch_get_main_queue()) {
//
//                        
//                    }
//                }
//            
////                post.image1 = UIImage(data: data!, scale:1.0)
//            }
//            // 9
//            self.tableView.reloadData()
//        }
//    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // TODO: make a condition you have to check and see if we have a current user location or no if no show another viewcontroller
        
        
        if let userlocation = self.userlocation {
        
            ParseHelper.timelineRequestforCurrentLocation(self.userlocation!) {
                (result: [AnyObject]?, error: NSError?) -> Void in
                self.posts = result as? [Post] ?? []
                
                self.tableView.reloadData()
            }
        
        }
        else {
        
        println("no user location")
        
        }
        
           }

}

extension TimelineViewController: UITableViewDataSource {
    
  
  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
      return posts.count

        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
        
      let post = posts[indexPath.row]

        // 1
        post.downloadImage()
        // 2
        cell.post = post
        cell.timeline = self

        return cell
    }
}





