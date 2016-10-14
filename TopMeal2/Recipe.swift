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
        
    var name: String {
        return _name
    }
    
    var id: Int {
        return _id
    }
    
    init(_ name: String, _ id: Int) {
        _name = name
        _id = id
    }
    
    convenience init() {
        self.init("", 0) //TODO: Bad way to do this, I assume, figure something better out
        
    }
    
    var thumbnailImageURLString: String {
        return "http://topmeal-142219.appspot.com/get_image?type=thumbnail&id=" + String(_id)
    }
}
