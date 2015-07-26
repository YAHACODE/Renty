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


class TimelineViewController: UIViewController {
    
    var manager: OneShotLocationManager?
    var posts: [Post] = []

    @IBOutlet weak var tableView: UITableView!

   
    
    
    override func viewDidLoad() {
       

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
            self.manager = nil
        }

        
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        /*/ 1
        let followingQuery = PFQuery(className: "Follow")
        followingQuery.whereKey("fromUser", equalTo:PFUser.currentUser()!)
        
        // 2
        let postsFromFollowedUsers = Post.query()
        postsFromFollowedUsers!.whereKey("user", matchesKey: "toUser", inQuery: followingQuery)
        
        // 3
        let postsFromThisUser = Post.query()
        postsFromThisUser!.whereKey("user", equalTo: PFUser.currentUser()!)
        
        // 4
        let query = PFQuery.orQueryWithSubqueries([postsFromFollowedUsers!, postsFromThisUser!])
        // 5
        query.includeKey("user")
        // 6
        query.orderByDescending("createdAt")
        
        // 7*/

        
        
        let postsQuery = Post.query()

        postsQuery!.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            // 8
            self.posts = result as? [Post] ?? []
            // 9
            self.tableView.reloadData()
        }
    }
    
    

}

extension TimelineViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 2
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! UITableViewCell
        
        cell.textLabel!.text = "Post"
        
        return cell
    }
    
}

//extension TimelineViewController: UITabBarControllerDelegate {
//    
//    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
//        if (viewController is PhotoTakingViewController) {
//            println("Take Photo")
//
//            return false
//        } else {
//            return true
//        }
//    }
//    
//}





