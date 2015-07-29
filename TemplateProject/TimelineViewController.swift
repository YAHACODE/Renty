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
                
                //self.tableView.reloadData()
                let posts = result as? [Post] ?? []
                // 3
                completionBlock(posts)
                
                
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
        
//      let post = posts[indexPath.row]
        
        let post = timelineComponent.content[indexPath.row]


        // 1
        post.downloadImage()
        // 2
        cell.post = post
     //   cell.timeline = self

        return cell
    }
}


extension TimelineViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        timelineComponent.targetWillDisplayEntry(indexPath.row)
    }
    
}



