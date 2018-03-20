//
//  SearchResultsManager.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 22/10/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import Foundation


class SearchResultsManager: Loadable {
    
    var users: [User] = []
    
    var searchString: String = ""
    //MARK: Loadable
    
    func getURLFetchString() -> String {
        return "http://topmeal-142219.appspot.com/find_user?string=" + searchString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    
    func loadArray(array: Array<Dictionary<String, AnyObject>> ){
        self.users = []
        for postDict in array{
            let user = User(dict: postDict)
            self.users.append(user)
        }
    }
    
    func performSearch(searchString: String, completed: @escaping (ServerRequestResponse) -> Void) {
        
        //Add more additional logic to prepare the search request
        if searchString == "" {
            return
        }
        self.searchString = searchString
        self.load(){ result in
            completed(result)
            
        }
    }
    
    func count() -> Int {
        return self.users.count
    }
    

    
}
