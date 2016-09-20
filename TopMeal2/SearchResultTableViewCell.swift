//
//  SearchResultTableViewCell.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 20/09/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cookingTimeLabel: UILabel!
    @IBOutlet weak var matchRatingLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(searchResult: RecipeSearchResult)
    {
        self.nameLabel.text = searchResult.name
        self.matchRatingLabel.text = String(searchResult.matchRating) + "%"
    }
    
    

}
