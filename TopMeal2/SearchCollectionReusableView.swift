//
//  SearchCollectionReusableView.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 16/09/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit

class SearchCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var slider: UISlider!
    
    weak var parent: SearchCollectionViewController?
    
    @IBAction func cookingTimeSliderValueChanged(_ sender: AnyObject) {
        self.parent?.cookingTimeSliderValue = slider.value
        //TODO: Implement changing label
        print(self.parent?.cookingTimeSliderValue)
    }
    
}
