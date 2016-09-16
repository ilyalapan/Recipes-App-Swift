//
//  IngridientsChoice.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 15/09/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import Foundation

class  IngridientsChoice  {
    private var _title: String = ""
    private var _identifier: String = ""
    private var _ingridients: String = ""
    
    var title: String {
        return _title
    }
    
    var identifier: String {
        return _identifier
    }
    
    var ingridients: String {
        return _ingridients
    }
    
    init(title: String, identifier : String, ingridients: String) {
        
        self._title = title
        self._identifier = identifier
        self._ingridients = ingridients
    }
    

}
