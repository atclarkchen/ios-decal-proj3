//
//  PhotosCollectionViewController.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit
import Foundation

class PhotosCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var collection: UICollectionView!

    
    //collection view flow layout
    
    var photos: [Photo]!
    var userName = ""
    var datePosted: NSDate!
    var numberLikes: Int!
    var viewImage: UIImage!
    
//    var indexSelected: Int!
    
    override func viewDidLoad() {
        print("photocollectionVC:viewDidLoad")
        photos = [Photo]()
        super.viewDidLoad()

        
        
        let api = InstagramAPI()
        api.loadPhotos(didLoadPhotos)
        // FILL ME IN
        print("in PhotosCollectionVC: ViewDidLoad!")
        
        
        
    }


    
    /* Creates a session from a photo's url to download data to instantiate a UIImage. 
       It then sets this as the imageView's image. */
    func loadImageForCell(photo: Photo, imageView: UIImageView) {
       
        
//        let downloadQueue = dispatch_queue_create("com.photos.processDownload", nil)
//        dispatch_async(downloadQueue) {
//
//            var data = NSData(contentsOfURL: NSURL(fileURLWithPath: photo.url))
//            var image: UIImage?
//            if data != nil {
//                photo.imageData = data
//                image = UIImage(data: data!)
//            }
//            
//            dispatch_async(dispatch_get_main_queue()) {
//                imageView.image = image
//            }
//        }
        
            var photoURL = NSURL(string: photo.url)!
            //create a session from this URL to download data to create and instantiate UIImage
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(photoURL) {
                (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                if error == nil {

                    let img = UIImage(data: data!)
                    imageView.image = img //set the UIImageView
                    
                    //each time you loadImage, set Photo object's data !
                    photo.imageData = data
                }
            }
            task.resume()
            print("PhotoCollectionVC: Load Image for Cell!")

    }
    

    
    /*
    * IMPLEMENT ANY COLLECTION VIEW DELEGATE METHODS YOU FIND NECESSARY
    * Examples include cellForItemAtIndexPath, numberOfSections, etc.
    */
    
    /* delegate method CellForItematIndexPath ; CONFIGURE THE CELL HERE. */
    override func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        // configure the CELL
        print("incellforrow")

        let cell = collection.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! CollectionViewCell
            
        let img = cell.cell_Image
        let photo = photos[indexPath.row]

            
        print("loading photo at cell: \(indexPath.row)")
            
        loadImageForCell(photo, imageView: img)//pass in Cell's imageView
        return cell

    }
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        print("delegate2")
        return 1
    }

    /* delegate method numItemsInSection; CRASHES item width must be less than the width of the UICollectionView minus the section insets left and right values, minus the content insets left and right values. */
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        // Get INDEXPATH OF CELL
        var cell = sender as! CollectionViewCell
        var indexPath_of_cell = collectionView?.indexPathForCell(cell)
        

        var photo = photos[indexPath_of_cell!.row]
        
        
        // set attributes
        self.userName = photo.username
        print("HELLOOOOO \(userName)")
        //        self.datePosted =
        self.numberLikes = photo.likes
        self.datePosted = photo.datePosted
        
        //        self.indexSelected = indexPath.row
        
        self.viewImage = UIImage(data: photo.imageData!) // SET view image here, gets passed to Destination!

        
        
        
        
        //need reference to destination
        print("prepareForSegue!")
        if segue.identifier == "displayDetail" {
//            var destination: StatsViewController = segue.destinationViewController as! StatsViewController
//            if self.clearTasks {
//                self.numCompletedTasks = 0
//                self.clearTasks = false //reset to false
//            }
//            destination.numCompleted = self.numCompletedTasks // set the num tasks of stats
            print("segue_display")
            
            
            var destination: PhotoViewController = segue.destinationViewController as! PhotoViewController
            destination.userName = self.userName
            destination.datePosted = String(self.datePosted)
            destination.numberLikes = self.numberLikes
            destination.viewImage = self.viewImage
            
        }
    }

    
    
    
    /* */
    
    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadPhotos(photos: [Photo]) {
        print("RELOAD DATA: photos is no longer empty!")
        self.photos = photos
        // self.collectionView!.reloadData()
        self.collection!.reloadData()
    }
    
}

