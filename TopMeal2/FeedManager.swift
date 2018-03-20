//
//  FeedObject.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 12/10/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import Foundation
import Alamofire


class FeedManager: Loadable,Pagination {
    
    var posts: [FeedPost] = []
    
    
    //MARK: Loadable 
    
    func getURLFetchString() -> String {
        return "http://topmeal-142219.appspot.com/get_feed?start=0"
    }

    
    func loadArray(array: Array<Dictionary<String, AnyObject>> ){
        self.posts = []
        for postDict in array{
            let post = FeedPost(dict: postDict)
            self.posts.append(post)
        }
    }
    
    
    //MARK: Pagination
    
    
    func updateArray(array: Array<Dictionary<String, AnyObject>> ){
        for postDict in array{
            let post = FeedPost(dict: postDict)
            self.posts.append(post)
        }
    }
    
    
    func getURLMoreString() -> String {
        return "http://topmeal-142219.appspot.com/get_feed?start=" + String(posts.count)
    }
    
    func count() -> Int {
        return self.posts.count
    }

}
