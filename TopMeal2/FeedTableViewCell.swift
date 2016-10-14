//
//  FeedTableViewCell.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 12/10/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var posterNameLabel: UILabel!

    @IBOutlet weak var recipeNameButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    
    func configureCell(post: FeedPost)
    {
        print(post.recipe.name + "!!!!") //DEBUG
        self.recipeNameButton.setTitle(post.recipe.name, for: .normal)
        
        let URLphoto = NSURL(string: post.postImageURLString())
        self.photoImageView.sd_setImage(with: URLphoto?.absoluteURL)
        
        let URLprofile = NSURL(string: post.user.profileImageURLString())
        self.profilePicImageView.sd_setImage(with: URLprofile?.absoluteURL)
    }


}
