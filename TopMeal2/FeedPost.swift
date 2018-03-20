//
//  FeedPost.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 12/10/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import Foundation
import Alamofire


//TODO: this should inherit from Post or just simply renamed to Post as this is not specific to Feed


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


    var numLikes: Int
    var liked: Bool



    
    init(dict: Dictionary<String,AnyObject>){
        
        _recipe = Recipe( (dict["recipeName"] as? String)!, (dict["recipeID"] as? Int)! )
        _id = Int((dict["id"] as? Int)!)
        _time = NSDate(timeIntervalSince1970: (dict["recipeID"] as? Double)!)
        _user = User(uid: dict["userID"] as! String, name: dict["name"] as! String)
        if dict["isLiked"] as! String == "true" {
            liked = true
        } else {
            liked = false
        }
        if let likes = dict["numLikes"] as? Int {
            self.numLikes = likes
        }
        else {
            self.numLikes = 0
        }
        
    }
    
    
    func postImageURLString() -> String {
        return "http://topmeal-142219.appspot.com/get_image?type=post&id=" + String(_id)
    }
    
    
    func like(idToken: String , completed: @escaping (ServerRequestResponse) -> Void ) {
        
        let tmp_liked = liked
        let tmp_numLikes = numLikes
        
        if self.liked {
            self.liked = false
            self.numLikes -= 1
        } else {
            self.liked = true
            self.numLikes += 1
        }
        
        let headers = ["Authorization": "Bearer " + idToken,] //pass token in the header
        let URLString = "http://topmeal-142219.appspot.com/like_post?post="+String(_id) //request sting
        
        Alamofire.request(URLString,headers: headers).responseJSON{ response in
            do{
                try RequestHelper.checkStatus(responseJSON: response)
                completed(ServerRequestResponse.Success)
                return
            }
            catch {
                self.liked = tmp_liked
                self.numLikes = tmp_numLikes
                completed(ServerRequestResponse.Failed)
                return
            }
        }
    }
    
        
}
