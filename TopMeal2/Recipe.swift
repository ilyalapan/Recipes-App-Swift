//
//  Recipe.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 16/09/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import Foundation


class Recipe {
    
    var _name : String = ""
    var _id: Int = 0
    
    //TODO: Need getters
    
    var name: String {
        return _name
    }
    
    init(name: String, id: Int) {
        _name = name
        _id = id
    }
}
