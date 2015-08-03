//
//  TagsPageViewController.swift
//  Renty
//
//  Created by yahya on 8/2/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class TagsPageViewController: UIViewController {

    var posts: [Post] = []
    var selectedPost: Post?

    var selectedTag:String = "Sporting Goods"
    
    
//    products = ["Fashion", "Home and decor", "Electronics", "Baby and kids" , "Collectibles and Art", "Sporting Goods","Automobile", "other stuff"]
    

    
    
    @IBOutlet weak var tableView: UITableView!
    
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
        
        // 1
       let query = Post.query()
       
        query!.includeKey("user")
        query!.whereKey("tag", equalTo: selectedTag)

        // 6
      //  query!.orderByDescending("createdAt")
        

        // 7
        query!.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            // 8
            self.posts = result as? [Post] ?? []
            // 9
            self.tableView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowExistingPostTag" {
            let postViewControler = segue.destinationViewController as! ProductPageViewController
            
            postViewControler.post = selectedPost
            
        }
        
    }
    

}

extension TagsPageViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 2
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCellTags") as! PostTableViewCell
        

        let post = posts[indexPath.row]

       // cell.textLabel!.text = "Post"
        post.downloadImage()
        // 2
        cell.post = post
        return cell
    }
    
}

extension TagsPageViewController: UITableViewDelegate {
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        selectedPost = posts[indexPath.row] //1
        self.performSegueWithIdentifier("ShowExistingPostTag", sender: self) //2
        // println(selectedPost)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    //    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    //
    //        timelineComponent.targetWillDisplayEntry(indexPath.row)
    //    }
    
    
    
    
    
}