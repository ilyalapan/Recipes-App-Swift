//
//  SearchCollectionViewCell.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 15/09/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var choice : IngridientsChoice!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(choice: IngridientsChoice)
    {
        self.choice = choice
        self.label.text = self.choice.title
        self.imageView.image = UIImage(named: self.choice.identifier)
    }
    
}
