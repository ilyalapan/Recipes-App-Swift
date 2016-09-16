//
//  RevealViewController.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 16/09/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit

class RevealViewController: SWRevealViewController, SWRevealViewControllerDelegate {
    var selectedIngridients: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
        if let destination = revealController.rightViewController as? IngridientsChoiceTableViewController{
            destination.selectedIngridients = selectedIngridients
        }
        
    }

    

}
