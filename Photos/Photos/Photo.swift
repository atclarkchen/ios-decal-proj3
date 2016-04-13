//
//  Photo.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import Foundation

class Photo {
    /* The number of likes the photo has. */
    var likes : Int!
    /* The string of the url to the photo file. */
    var url : String!
    /* The username of the photographer. */
    var username : String!
    /* Heart button state that shows whether the photo has been liked or not. */
    var isHearted : Bool
    /* Date photo was posted. */
    var datePosted : NSDate!
    /* Image data for photo */
    var imageData : NSData?
    
    
    /* Parses a NSDictionary and creates a photo object. */
    init (data: NSDictionary) {
        // FILL ME IN
        // HINT: use nested .valueForKey() calls, and then cast using 'as! TYPE'
        
        
        // represents single photo object
        
        // need to set "likes", "url", and "username"
        // why nested?

        
        // use https://www.instagram.com/developer/endpoints/media/#get_media as reference for data structure

        self.likes = data.valueForKey("likes")?.valueForKey("count") as! Int // "likes" => {"count": value}

        var images = data.valueForKey("images")
        self.url = images!.valueForKey("standard_resolution")?.valueForKey("url") as! String
        self.username = data.valueForKey("user")?.valueForKey("username") as! String
        var timestamp = Double(data.valueForKey("created_time") as! String)
        self.datePosted = NSDate(timeIntervalSince1970: timestamp!)

        
//        print("making a photo!")
//        print("num likes: \(self.likes)")
//        print("user is: \(self.username)")
//        print("url is: \(self.url)")
        
        
        if self.likes > 0 {
            isHearted = true
        } else {
            isHearted = false
        }
    }

}