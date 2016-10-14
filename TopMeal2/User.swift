//
//  User.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 14/10/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import Foundation


class User {
    let _uid : String
    
    var uid : String {
        return _uid
    }
    
    init(uid: String) {
        _uid = uid
    }
    
    func profileImageURLString()->String {
        return "http://topmeal-142219.appspot.com/get_image?type=profile&id=" + String(_uid)
    }
}
