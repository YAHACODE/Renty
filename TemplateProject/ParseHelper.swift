//
//  ParseHelper.swift
//  Renty
//
//  Created by yahya on 7/26/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Foundation
import Parse


class ParseHelper {
 

    static func timelineRequestforCurrentLocation(range: Range<Int>,location : PFGeoPoint,completionBlock: PFArrayResultBlock) {

        
        // Create a query for post
        var query = PFQuery(className:"Post")
        // Interested in locations near user.
        query.whereKey("postlocation", nearGeoPoint:location, withinMiles: 30)
        // Limit what could be a lot of points.
        //  query.limit = 50
        query.orderByDescending("createdAt")
        query.includeKey("user")
        query.skip = range.startIndex
        query.limit = range.endIndex - range.startIndex
        query.findObjectsInBackgroundWithBlock(completionBlock)
        
  
  
        }


}
