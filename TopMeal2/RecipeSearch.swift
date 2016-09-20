//
//  RecipeSearch.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 16/09/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import Foundation
import Alamofire

class RecipeSearch {
    
    var ingridients: [String] = []
    var vegetarian: Bool = false
    var cookingTime: Int = 0
    
    var searchResults: [RecipeSearchResult] = []
    
    
    func searchResultsURLString() -> String{
        let ingredientStrings = self.ingridients.map{ $0.lowercased() }
        var URLString = "http://topmeal-142219.appspot.com/search?ingredients=" + ingredientStrings.joined(separator: ",").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        URLString = URLString + "&start=" + String(self.searchResults.count - 1) // (- 1) because indexing of search result starts from 0 in SQL
        print(URLString) //DEBUG
        //TODO: Add vegan, add cookingTime (server side too) and redo this using closures
        return URLString
    }
    
    
    
    func loadArray(array: Array<Dictionary<String, AnyObject>> ){
        for recipeSearchResultDict in array{
            let result = RecipeSearchResult(dict: recipeSearchResultDict)
            self.searchResults.append(result)
        }
    }
    
    func loadNextSearchResults(completed: @escaping (String) -> Void )  {
        
        let URLString = self.searchResultsURLString()
        print(URLString) //DEBUG
        Alamofire.request(URLString).responseJSON{ response in
            
            print(response.request) //DEBUG // original URL request
            print(response.response)//DEBUG // HTTP URL response
            print(response.data)  //DEBUG   // server data
            print(response.result) //DEBUG  // result of response serialization
            
            if let JSON = response.result.value {
                if let dict =  JSON as? Dictionary<String, AnyObject>{
                    if let searchResArray = dict["searchResults"] as? [Dictionary<String,AnyObject>] {
                        if searchResArray.count == 0 {
                            completed("No results")
                            return
                        }
                        self.loadArray(array: searchResArray)
                        completed("Success") //All is good, return
                        return
                    }
                }
            }
            completed("Unknown Error") //Did not catch error
        }
    }
    
    func loadInitialSearchResults(completed: @escaping (String) -> Void )  {
        self.searchResults = []
        self.loadNextSearchResults(completed: completed)
        
    }

    
    
}
