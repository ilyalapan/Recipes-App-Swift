//
//  DiscoverManager.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 21/10/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import Foundation


class DiscoverFeedManager: Loadable, Pagination{
    
    var posts: [FeedPost] = []
    
    //MARK:Loadable
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
    
    func count() -> Int {
        return self.posts.count
    }
    
    //MARK:Pagination
    
    func updateArray(array: Array<Dictionary<String, AnyObject>> ){
        for postDict in array{
            let post = FeedPost(dict: postDict)
            self.posts.append(post)
        }
    }
    
    
    
    func getURLMoreString() -> String {
        return "http://topmeal-142219.appspot.com/get_feed?start=" + String(posts.count)
    }
    
    
    
    
}
