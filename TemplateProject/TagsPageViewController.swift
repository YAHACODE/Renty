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

    
    var user : User?
    var posts: [Post] = []
    var selectedPost: Post?

    var userlocation: PFGeoPoint?
    var selectedTag:String = "Sporting Goods"
    var manager: OneShotLocationManager?
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
                // println(err.localizedDescription)

            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func getusercurrentlocation() {
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (userlocation: PFGeoPoint?, error: NSError?) -> Void in
            if error == nil {
                
                self.userlocation = userlocation
                
                print(userlocation)
                
            }
        }
    }

    
    func loadInRange(range: Range<Int>, completionBlock: ([Post]?) -> Void) {
        

           let query = Post.query()
           query!.includeKey("user")
           query!.whereKey("tag", equalTo: self.selectedTag)
            //query!.whereKey("postlocation", nearGeoPoint:userlocation, withinMiles: 50)
            
           query!.orderByDescending("createdAt")
           query!.skip = range.startIndex
           query!.limit = range.endIndex - range.startIndex
           query!.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
                // 8
                self.posts = result as? [Post] ?? []
                completionBlock(self.posts)

            
        }
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        timelineComponent.loadInitialIfRequired()

        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowExistingPost" {
            let postViewControler = segue.destinationViewController as! ProductPageViewController
            
            postViewControler.post = selectedPost

            
        }
        
    }
    


}



extension TagsPageViewController: UITableViewDataSource {
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelineComponent.content.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCellTags") as! PostTableViewCell
        let post = timelineComponent.content[indexPath.row]
           post.downloadImage()
        cell.post = post
        return cell
    }
    
}
extension TagsPageViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        timelineComponent.targetWillDisplayEntry(indexPath.row)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedPost =  self.timelineComponent.content[indexPath.row]
        self.performSegueWithIdentifier("ShowExistingPost", sender: self) //2
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
}
    

