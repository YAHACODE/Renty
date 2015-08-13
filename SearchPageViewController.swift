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
    
    let tagImages: [String] = ["Fashion.jpg", "Home and decor.jpg", "Electronics.jpg", "baby.jpg" , "Collectibles and Art.jpg", "Sporting Goods.jpg","Automobile.jpg", "other stuff.jpg"]
    
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
        let cell = tableView.dequeueReusableCellWithIdentifier("TagCell") as! tagTableCell
        
        cell.backgroundImageView.image = UIImage(named:tagImages[indexPath.row])
        cell.titleLabel.text = tags[indexPath.row]
        
//        cell.backgroundImageView.layer.cornerRadius = cell.backgroundImageView.frame.height/2.0
//        cell.backgroundImageView.clipsToBounds = true
        
        cell.tagView.layer.cornerRadius = cell.tagView.frame.height/2.0
        cell.tagView.clipsToBounds = true
        
        return cell
    }
}


extension SearchPageViewController: UITableViewDelegate {
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //   selectedPost = posts[indexPath.row] //1
        self.performSegueWithIdentifier("ToTagsSegue", sender: self) //2
    }
}

class tagTableCell : UITableViewCell {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tagView: UIView!
    
    
}


