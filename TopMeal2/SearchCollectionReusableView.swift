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
    @IBOutlet weak var sliderLabel: UILabel!
    
    weak var parent: SearchCollectionViewController?
    
    @IBAction func cookingTimeSliderValueChanged(_ sender: AnyObject) {
        var value: Float = slider.value
        if value<0.2 {
            value = 0.2
        }
        else if value > 0.2 && value < 0.4 {
            value = 0.3
        }
        else if  value < 0.4 && value < 0.6 {
            value = 0.5
        }
        else {value = 0.8} //TODO
        self.parent?.cookingTimeSliderValue = value
        //TODO: Implement changing label
        self.sliderLabel.text = "Время приготовления: <" + String(value*120) + "мин."
        print(self.parent?.cookingTimeSliderValue)
    }
    @IBAction func searchButton(_ sender: AnyObject) {
        self.parent?.performRecipeSearch() //TODO: Make Floating Button
    }
    //TODO: Work on interface
    
}
