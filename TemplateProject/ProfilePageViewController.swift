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

class ProfilePageViewController: UIViewController {
    
    
    @IBOutlet weak var tableview: UITableView!
    var posts: [Post] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
        
        
        postsQuery!.whereKey("user", equalTo: PFUser.currentUser()!)

        
        postsQuery!.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            // 8
            self.posts = result as? [Post] ?? []
            // 9
            
            self.tableview.reloadData()
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
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! UITableViewCell
        
        cell.textLabel!.text = "Post"
        
        return cell
    }
    
}