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
 
 
    
    static func timelineRequestforCurrentLocation(range: Range<Int>,location : PFGeoPoint,completionBlock: PFArrayResultBlock) {
        
        
        // Create a query for places
        var query = PFQuery(className:"Post")
        // Interested in locations near user.
        query.whereKey("postlocation", nearGeoPoint:location, withinMiles: 0)
        // Limit what could be a lot of points.
        query.limit = 10

        

//        let postsQuery = Post.query()
//                postsQuery!.includeKey("user")
//                postsQuery!.orderByDescending("createdAt")
//        

        
        query.skip = range.startIndex
        // 3
        query.limit = range.endIndex - range.startIndex
        
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
}
