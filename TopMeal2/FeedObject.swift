//
//  FeedObject.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 12/10/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import Foundation
import Alamofire


class FeedObject: Loadable {
    var posts: [FeedPost] = []
    
    func loadArray(array: Array<Dictionary<String, AnyObject>> ){
        for postDict in array{
            let post = FeedPost(dict: postDict)
            self.posts.append(post)
        }
    }
    
    func getURLFetchString() -> String {
        return "http://topmeal-142219.appspot.com/get_feed?start=0"
    }
    
    
    /* Should be replaced by protocol
    func refreshPosts(idToken: String, completed: @escaping (String) -> Void )  {
        let headers = ["Authorization": "Bearer " + idToken,]
        let URLString = "http://topmeal-142219.appspot.com/get_feed?start=0"
        
        Alamofire.request(URLString, headers: headers).responseJSON{ response in
            
            print(response.request) //DEBUG // original URL request
            print(response.response)//DEBUG // HTTP URL response
            print(response.data)  //DEBUG   // server data
            print(response.result) //DEBUG  // result of response serialization
            
            if let JSON = response.result.value {
                if let dict =  JSON as? Dictionary<String, AnyObject>{
                    if let postsArray = dict["posts"] as? [Dictionary<String,AnyObject>] {
                        self.posts = []
                        self.loadArray(array: postsArray)
                        completed("Success") //All is good, return //TODO: Use ServerRequestResponse  return
                        return
                    }
                }
            }
            completed("Unknown Error") //Did not catch error
        }
    }*/

    
    func loadNextPosts(idToken: String,completed: @escaping (String) -> Void )  {
        let headers = ["Authorization": "Bearer " + idToken,]
        let URLString = "http://topmeal-142219.appspot.com/get_feed?user_id=4WM4TNtJa1UIkeZdP9Y41Wa1Jqi2&start=0"
        
        Alamofire.request(URLString,headers: headers).responseJSON{ response in
            
            if let JSON = response.result.value {
                if let dict =  JSON as? Dictionary<String, AnyObject>{
                    if let postsArray = dict["posts"] as? [Dictionary<String,AnyObject>] {
                        self.loadArray(array: postsArray)
                        completed("Success") //All is good, return
                        return
                    }
                }
            }
            completed("Unknown Error") //Did not catch error
        }
    }

    
}
