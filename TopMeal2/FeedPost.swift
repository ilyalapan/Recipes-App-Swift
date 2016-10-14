//
//  FeedPost.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 12/10/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import Foundation


class FeedPost{
    let _recipe: Recipe
    let _id: Int
    let _time: NSDate
    let _user: User
    
    var recipe: Recipe {
        return _recipe
    }
    
    var id: Int {
        return _id
    }
    
    var time: NSDate {
        return _time //TODO: change that to "2 hours ago"
    }
    
    var user:User {
        return _user
    }


    func postImageURLString() -> String {
        return "http://topmeal-142219.appspot.com/get_image?type=post&id=" + String(_id)
    }
    
    init(dict: Dictionary<String,AnyObject>){
        
        _recipe = Recipe( (dict["recipeName"] as? String)!, (dict["recipeID"] as? Int)! )
        _id = Int((dict["id"] as? Int)!)
        _time = NSDate(timeIntervalSince1970: (dict["recipeID"] as? Double)!)
        _user = User(uid: dict["userID"] as! String)
    }
}
