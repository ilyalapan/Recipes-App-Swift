//
//  DiscoverSearchResultCell.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 22/10/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit

class DiscoverSearchResultCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(user: User) {
        self.label.text = user.name
        self.photoImageView.sd_setImage(string: user.profileImageURLString() )
    }

}
