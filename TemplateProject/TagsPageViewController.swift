//
//  TagsPageViewController.swift
//  Renty
//
//  Created by yahya on 8/2/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import ConvenienceKit



class TagsPageViewController: UIViewController,  TimelineComponentTarget  {

    var posts: [Post] = []
    var selectedPost: Post?
   
    var userlocation: PFGeoPoint?

    var selectedTag:String = "Sporting Goods"
    var manager: OneShotLocationManager?

    
//    products = ["Fashion", "Home and decor", "Electronics", "Baby and kids" , "Collectibles and Art", "Sporting Goods","Automobile", "other stuff"]
    
    let defaultRange = 0...4
    let additionalRangeSize = 5
    var timelineComponent: TimelineComponent<Post, TagsPageViewController>!

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        timelineComponent = TimelineComponent(target: self)

        getusercurrentlocation()
        super.viewDidLoad()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func getusercurrentlocation() {
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (userlocation: PFGeoPoint?, error: NSError?) -> Void in
            if error == nil {
                
                self.userlocation = userlocation
                
                println(userlocation)
                
            }
        }
    }

    func loadInRange(range: Range<Int>, completionBlock: ([Post]?) -> Void) {
        // 1
       // if let userlocation = self.userlocation {
            // 1
            let query = Post.query()
            
            //println(userlocation)
            query!.includeKey("user")
            query!.whereKey("tag", equalTo: selectedTag)
            //query!.whereKey("postlocation", nearGeoPoint:userlocation, withinMiles: 50)
            
            // 6
            //  query!.orderByDescending("createdAt")
            
        query!.skip = range.startIndex
        // 3
        query!.limit = range.endIndex - range.startIndex
        
        
            // 7
            query!.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
                // 8
                self.posts = result as? [Post] ?? []
                // 9
              //  self.tableView.reloadData()
                completionBlock(self.posts)

            }
//        //}
//        else {
//            
//           // println("no user location")
//            
//        }
        
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        timelineComponent.loadInitialIfRequired()

        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowExistingPostTag" {
            let postViewControler = segue.destinationViewController as! ProductPageViewController
            
            postViewControler.post = selectedPost
            
        }
        
    }
    
  
    
    
    
    

}



extension TagsPageViewController: UITableViewDataSource {
    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // 1
//        return posts.count
//    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelineComponent.content.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 2
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCellTags") as! PostTableViewCell
        

        //let post = posts[indexPath.row]
        let post = timelineComponent.content[indexPath.row]

       // cell.textLabel!.text = "Post"
        post.downloadImage()
        // 2
        cell.post = post
        return cell
    }
    
}

extension TagsPageViewController: UITableViewDelegate {
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        timelineComponent.targetWillDisplayEntry(indexPath.row)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
//        selectedPost = posts[indexPath.row] //1
        selectedPost =  self.timelineComponent.content[indexPath.row]

        self.performSegueWithIdentifier("ShowExistingPostTag", sender: self) //2
        // println(selectedPost)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
   
    
    
    
    
}