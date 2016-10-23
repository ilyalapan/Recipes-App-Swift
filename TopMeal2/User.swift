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
    
    
    var name : String = ""
    
    
    init(uid: String) {
        _uid = uid
    }
    
    convenience init(uid: String, name: String) {
        self.init(uid: uid)
        self.name = name
    }
    
    convenience init(dict: [String: AnyObject]) {
        self.init(uid: dict["userID"] as! String )
        self.name = dict["name"] as! String

    }

    
    func profileImageURLString()->String {
        return "http://topmeal-142219.appspot.com/get_image?type=profile&id=" + String(_uid)
    }
}

