//
//  ParseHelper.swift
//  Renty
//
//  Created by yahya on 7/26/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Foundation
import Parse

// 1
class ParseHelper {
 
//    @NSManaged var userlocation: PFGeoPoint?

    // 2
    
    
    static func timelineRequestforCurrentLocation(location : PFGeoPoint,  completionBlock: PFArrayResultBlock) {
      
        
        
        
//        let followingQuery = PFQuery(className: "Follow")
//        followingQuery.whereKey("fromUser", equalTo:PFUser.currentUser()!)
//        
//        let postsFromFollowedUsers = Post.query()
//        postsFromFollowedUsers!.whereKey("user", matchesKey: "toUser", inQuery: followingQuery)
//        
//        let postsFromThisUser = Post.query()
//        postsFromThisUser!.whereKey("user", equalTo: PFUser.currentUser()!)
//        
//        let query = PFQuery.orQueryWithSubqueries([postsFromFollowedUsers!, postsFromThisUser!])
//        query.includeKey("user")
//        query.orderByDescending("createdAt")
//        query.findObjectsInBackgroundWithBlock(completionBlock)
//
//         3
    
//        let userObject = []
//
//
//        // User's location
//        let userGeoPoint = Post()["userlocation"] as! PFGeoPoint
//        // Create a query for places
//        var query = PFQuery(className:"PlaceObject")
//        // Interested in locations near user.
//        query.whereKey("location", nearGeoPoint:userGeoPoint)
//        // Limit what could be a lot of points.
//        query.limit = 10
//        // Final list of objects
//        placesObjects = query.findObjects()
//        
        
//        // User's location
//        let userGeoPoint = userlocation["location"] as PFGeoPoint
        
        // Create a query for places
        var query = PFQuery(className:"Post")
        // Interested in locations near user.
        query.whereKey("postlocation", nearGeoPoint:location, withinMiles: 10)
        // Limit what could be a lot of points.
        query.limit = 10
        // Final list of objects
//        placesObjects = query.findObjects()
     
        
//
//        let postsQuery = Post.query()
//        
//                postsQuery!.includeKey("user")
//                postsQuery!.orderByDescending("createdAt")
//        

        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
}
