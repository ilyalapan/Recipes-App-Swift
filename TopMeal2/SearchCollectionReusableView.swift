//
//  SearchCollectionReusableView.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 16/09/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit

class SearchCollectionReusableView: UICollectionReusableView {
    
    weak var parent: SearchCollectionViewController?

    
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    
    @IBOutlet weak var veganButton: TagButton!
    @IBOutlet weak var dietButton: TagButton!
    @IBOutlet weak var noDairyButton: TagButton!
    @IBOutlet weak var noNutsButton: TagButton!
    @IBOutlet weak var noGlutenButton: TagButton!
    @IBOutlet weak var noHoneyButton: TagButton!
        
    
    
    @IBAction func cookingTimeSliderValueChanged(_ sender: AnyObject) {
        var value: Float = slider.value
        if value<20 {
            value = 20
        }
        else if value > 20 && value < 40 {
            value = 40
        }
        else if  value > 40 && value < 60 {
            value = 60
        }
        else if  value > 60 && value < 80 {
            value = 80
        }
        else if  value > 80 && value < 100 {
            value = 80
        }
        else if  value > 100 && value < 120 {
            value = 120
        }
        else {value = 99999} //Set big enough so that everything fits the criterion
        self.parent?.searchObject.cookingTime = Int(value)
        if value != 99999 {
            self.sliderLabel.text = "Время приготовления: <" + String(value) + "мин."
        }
        else {
            self.sliderLabel.text = "Время приготовления: любое"
        }
        print(self.parent?.cookingTimeSliderValue)
    }

    
    @IBAction func veganButtonPressed(_ sender: AnyObject) {
        self.parent?.veganButtonPressed(sender: (sender as? TagButton)!)
    }
    
    @IBAction func dietButtonPressed(_ sender: AnyObject) {
        self.parent?.dietButtonPressed(sender: (sender as? TagButton)!)
    }
    
    @IBAction func noDiaryButtonPressed(_ sender: AnyObject) {
        self.parent?.noDairyButtonPressed(sender: (sender as? TagButton)!)
    }
    
    @IBAction func noNutsButtonPressed(_ sender: AnyObject) {
        self.parent?.noNutsButtonPressed(sender: (sender as? TagButton)!)
    }
    
    @IBAction func noGlutenButtonPressed(_ sender: AnyObject) {
        self.parent?.noGlutenButtonPressed(sender: (sender as? TagButton)!)
    }
    
    @IBAction func noHoneyByttonPressed(_ sender: AnyObject) {
        self.parent?.noHoneyButtonPressed(sender: (sender as? TagButton)!)
    }
    
    
    
    
    
    
    
    
    
}
