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


class TimelineViewController: UIViewController, TimelineComponentTarget {
    
    let defaultRange = 0...4
    let additionalRangeSize = 5
    
    var manager: OneShotLocationManager?
    
    var posts: [Post] = []
    
    var userlocation: PFGeoPoint?

    var selectedPost: Post?
    @IBOutlet weak var tableView: UITableView!

    var timelineComponent: TimelineComponent<Post, TimelineViewController>!

    
    override func viewDidLoad() {
  
        self.getusercurrentlocation()
        timelineComponent = TimelineComponent(target: self)

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
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowExistingPost" {
    let postViewControler = segue.destinationViewController as! ProductPageViewController

        postViewControler.post = selectedPost
 
    }
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        timelineComponent.loadInitialIfRequired()
            
    }
    
    func loadInRange(range: Range<Int>, completionBlock: ([Post]?) -> Void) {
        
        if let userlocation = self.userlocation {
            ParseHelper.timelineRequestforCurrentLocation(range, location: self.userlocation!) { (result: [AnyObject]?, error: NSError?) -> Void in
               // self.posts = result as? [Post] ?? []
                println("user have location")
              //let posts = result as? [Post] ?? []
                //self.tableView.reloadData()
             self.posts = result as? [Post] ?? []
                // 3
                completionBlock(self.posts)
                
            }
        }
        else {
            
            println("no user location")
            
        }
        
    }
    
   
}




extension TimelineViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelineComponent.content.count
    }
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return Int(posts.count ?? 0)
//    }
//
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
        
        
        //let row = indexPath.row
     let post = self.timelineComponent.content[indexPath.row]
      //  let post = posts[row] as Post

        // 1
      post.downloadImage()
        // 2
        cell.post = post
      // cell.timeline = self

        return cell
    }
}


extension TimelineViewController: UITableViewDelegate {
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       selectedPost =  self.timelineComponent.content[indexPath.row]

     //   selectedPost = posts[indexPath.row] //1
        self.performSegueWithIdentifier("ShowExistingPost", sender: self) //2
        println(selectedPost)
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        timelineComponent.targetWillDisplayEntry(indexPath.row)
    }
    
}



