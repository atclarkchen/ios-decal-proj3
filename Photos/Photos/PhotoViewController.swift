//
//  PhotoViewController.swift
//  Photos
//
//  Created by Clark Chen on 4/11/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    
    var userName = ""
    var datePosted = ""
    var numberLikes: Int!
    var viewImage: UIImage!
    
    var imageLiked: Bool!
    
    
    @IBOutlet weak var user_name: UILabel!
    
    @IBOutlet weak var date_posted: UILabel!
    
    @IBOutlet weak var number_likes: UILabel!
    
    @IBOutlet weak var view_controller_image: UIImageView!
    
    
    @IBOutlet weak var button_object: UIButton!
    
    let checkedHeartImage = UIImage(named: "heart_checked.png")
    let uncheckedHeartImage = UIImage(named: "heart_unchecked.png")
    
    @IBAction func like_button(sender: AnyObject) {
        if imageLiked == true {
            imageLiked = false
            //set image to Unchecked Heart
            button_object.setBackgroundImage(uncheckedHeartImage, forState: UIControlState.Normal)
        } else {
            imageLiked = true
            //set image to Checked Heart
            button_object.setBackgroundImage(checkedHeartImage, forState: UIControlState.Normal)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("DSLKFJDSFLKDSJ")
        // Do any additional setup after loading the view.
        user_name.text = self.userName
        date_posted.text = self.datePosted
        var num = String(numberLikes)
        number_likes.text = num

        
        view_controller_image.image = nil
        view_controller_image.image = viewImage

        
        imageLiked = false
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

}
