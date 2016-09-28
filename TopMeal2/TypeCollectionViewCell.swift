//
//  TypeCollectionViewCell.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 27/09/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit

class TypeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    
    func configureCell(typeDict: Dictionary<String,String>,isSelected: Bool)
    {
        self.label.text = typeDict["Name"]
        self.imageView.image = UIImage(named: "meat")//typeDict["Identifier"]!)
        self.checkImageView.isHidden = !isSelected
    }


}

