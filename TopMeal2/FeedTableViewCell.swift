//
//  FeedTableViewCell.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 12/10/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    private var _liked: Bool = false
    private var _numLikes: Int = 0
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var posterNameLabel: UILabel!

    @IBOutlet weak var recipeNameButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var likesLabel: UILabel!
    
    
    
    func configureCell(post: FeedPost)
    {
        var name = post.recipe.name
        while name.characters.count > 33 {
            //format the string so its not too big for the button (format on word by word basis)
            var components : [String] = name.components(separatedBy: " ") //split in to an array of words
            components.removeLast() //this mutates the string, so no need to copy this to a new value
            name = components.joined(separator: " ")
            name += "..." //if the string size is still to big, the "..." will be thrown away with the last word
        }
        self.recipeNameButton.setTitle(name, for: .normal)
        self.recipeNameButton.sizeToFit()
        
        self.posterNameLabel.text = post.user.name
        
        self.photoImageView.sd_setImage(string: post.postImageURLString() )
        
        self.profilePicImageView.sd_setImage(string: post.user.profileImageURLString() )
        
        self._liked = post.liked
        self.likeButton.isSelected = self._liked
        
        self._numLikes = post.numLikes
        self.likesLabel.text = String(self._numLikes) + " likes"
    }
    
    
    func configureCellLikes(post: FeedPost)
    {
        self._liked = post.liked
        self.likeButton.isSelected = self._liked
        
        self._numLikes = post.numLikes
        self.likesLabel.text = String(self._numLikes) + " likes"
        
    }
    
    
    func switchCellLikedState() -> Void {
        if(!self._liked) {
            self.likeButton.isSelected = true
            _numLikes += 1
            self.likesLabel.text = String(_numLikes) + " likes"
            self._liked = true
        } else {
            self.likeButton.isSelected = false
            _numLikes -= 1
            self.likesLabel.text = String(_numLikes) + " likes"
            self._liked = false
            
        }
    }

}
