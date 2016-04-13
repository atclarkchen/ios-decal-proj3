//
//  InstagramAPI.Swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import Foundation

class InstagramAPI {
    /* Connects with the Instagram API and pulls resources from the server. */
    func loadPhotos(completion: (([Photo]) -> Void)!) {
        /* 
         * 1. Get the endpoint URL to the popular photos 
         *    HINT: Look in Utils
         * 2. Create a Session // THEY DID FOR US
         * 3. Create a Data Task with a URL and completionHandler
         *    If no error:
         *       a. Get NSDictionary from the JSON object, from key the "photos"
         *       b. Create Array of NSDictionaries (one NSDictionary for each photo)
         *       c. For each NSDictionary, create a Photo object, and add to Photos array
         *       d. Wait for completion of Photos array
         */
        // FILL ME IN
        var popularURL: NSURL = Utils.getPopularURL()  // 1. Get the endpoint URL to the popular photos

        let task = NSURLSession.sharedSession().dataTaskWithURL(popularURL) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil {
                //FIX ME
                var photos: [Photo] = [Photo]()
                
                // feedDictionary is a dictionary of hella dictionaries. CAST THIS AS AN ARRAY of DICTS.
                
                
                do {
                    let feedDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    // FILL ME IN, REMEMBER TO USE FORCED DOWNCASTING
                    
                    // get NSDictionary from the JSON object, from key the "photos"
 
                    //from feed find value for key "data" => lots of dictionaries
                    
//                    print("feed dict \(feedDictionary)")
                    
                    var list_dicts: [NSDictionary]
                    list_dicts = feedDictionary["data"] as! [NSDictionary]

                    //go through each element of list_dicts, init PHOTO, stuff into PHOTOS
                    for p_dict in list_dicts {
                        var curr_photo = Photo(data: p_dict)
                        photos.append(curr_photo)
//                        print("In InstagramAPI: made a photo!")
                    }
//                    print("photos: \(photos)")
                    // DO NOT CHANGE BELOW
                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                    dispatch_async(dispatch_get_global_queue(priority, 0)) {
                        dispatch_async(dispatch_get_main_queue()) {
                            completion(photos)
                        }
                    }
                } catch let error as NSError {
                    print("ERROR: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}