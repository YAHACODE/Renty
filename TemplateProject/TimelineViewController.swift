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
    // TODO: REMOVE THE EMAIL VIEW
    // TODO: FIX IMAGED IN SEARCH
    // TODO: INCREASE THE SPACING BETWEEN THE STATIC TOP BAR 
    let defaultRange = 0...10
    let additionalRangeSize = 10
    var posts: [Post] = []
    var manager: OneShotLocationManager?
    var userlocation: PFGeoPoint?
    var selectedPost: Post?
    var timelineComponent: TimelineComponent<Post, TimelineViewController>!
    var hasLocation:Bool = false
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    override func shouldAutorotate() -> Bool {
        return false
    }
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientation.Portrait.rawValue
    }
     override func viewDidLoad() {
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        self.getusercurrentlocation()
        timelineComponent = TimelineComponent(target: self)
        super.viewDidLoad()
        manager = OneShotLocationManager()
        manager!.fetchWithCompletion {location, error in
            // fetch location or an error
            if let loc = location {
            } else if let err = error {
            }
        }
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
                print(userlocation)
                if !self.hasLocation {
                    self.hasLocation = true
                    self.timelineComponent.loadInitialIfRequired()
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        timelineComponent.loadInitialIfRequired()
    }
    
    func loadInRange(range: Range<Int>, completionBlock: ([Post]?) -> Void) {
        if let userlocation = self.userlocation {
            ParseHelper.timelineRequestforCurrentLocation(range, location: self.userlocation!) { (result: [AnyObject]?, error: NSError?) -> Void in
                //println("user have location")
                self.posts = result as? [Post] ?? []
                completionBlock(self.posts)
            }
        }
        else {
            //println("no user location")
        }
        
         activityIndicator.hidden = true
        activityIndicator.stopAnimating()
    }
    @IBAction func unwindToTimelineVC (segue : UIStoryboardSegue ) {

    }
    
}

extension TimelineViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelineComponent.content.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
        let post = self.timelineComponent.content[indexPath.row]
        post.downloadImage()
        cell.post = post
        // cell.timeline = self
        return cell
    }
}

extension TimelineViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedPost =  self.timelineComponent.content[indexPath.row]
        self.performSegueWithIdentifier("ShowExistingPost", sender: self) //2
        print(selectedPost)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        timelineComponent.targetWillDisplayEntry(indexPath.row)
    }
    
}
