//
//  SearchPageViewController.swift
//  Renty
//
//  Created by yahya on 7/20/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Foundation
import UIKit
import Parse

let tags:[String] = ["Fashion", "Home and decor", "Electronics", "Baby and kids" , "Collectibles and Art", "Sporting Goods","Automobile", "other stuff"]


class SearchPageViewController : UIViewController {
    
    
//    @IBOutlet weak var tagImage: UIImageView!
//    
//      @IBOutlet weak var tagLabel: UILabel!
//
//    @IBOutlet weak var tagView: UIView!
    
    let tagImages: [String] = ["baby.jpg", "baby.jpg", "baby.jpg", "baby.jpg" , "baby.jpg", "baby.jpg","baby.jpg", "baby.jpg"]
    
    @IBOutlet weak var tagsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ToTagsSegue" {
            if let vc = segue.destinationViewController as? TagsPageViewController {
                if let ip = tagsTableView.indexPathForSelectedRow() {
                    vc.selectedTag = tags[ip.row]
                }
            }
        }
    }
}



extension SearchPageViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    //    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return Int(posts.count ?? 0)
    //    }
    //
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TagCell") as! UITableViewCell
        
        
        cell.textLabel!.text = tags[indexPath.row]
        return cell
    }
}


extension SearchPageViewController: UITableViewDelegate {
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //   selectedPost = posts[indexPath.row] //1
        self.performSegueWithIdentifier("ToTagsSegue", sender: self) //2
    }
}
