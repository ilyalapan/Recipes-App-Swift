//
//  RecipeSearchResult.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 16/09/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import Foundation


class RecipeSearchResult: Recipe {
    
    var matchedIngridients: [String] = []
    var matchRating: Int = 0
    
    init(dict: Dictionary<String,AnyObject>){
        super.init( name: (dict["recipeName"] as? String)!, id: (dict["recipeID"] as? Int)!)
        matchRating = Int((dict["rating"] as? String)!)!
    }

    
}
