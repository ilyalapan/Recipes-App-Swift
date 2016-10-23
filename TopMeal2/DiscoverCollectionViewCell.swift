//
//  DiscoverCollectionViewCell.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 21/10/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit

class DiscoverCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    func configureCell(post: FeedPost )
    {
        self.imageView.sd_setImage( string: post.postImageURLString() )
    }
    
}
