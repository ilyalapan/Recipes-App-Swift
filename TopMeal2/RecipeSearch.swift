//
//  RecipeSearch.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 16/09/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import Foundation
import Alamofire

class RecipeSearch: Loadable, Pagination {
    
    var ingridients: [String] = []
    var types: [String] = []
    
    var vegan: Bool = false
    var diet: Bool = false
    var noDairy: Bool = false
    var noNuts: Bool = false
    var noGluten: Bool = false
    var noHoney: Bool = false
    
    var cookingTime: Int = 0
    
    var noMoreResults: Bool = false
    
    var searchResults: [RecipeSearchResult] = []
    
    
    
    
    //#MARK: - Loadable
    
    func loadArray(array: Array<Dictionary<String, AnyObject>> ){
        self.searchResults = []
        for recipeSearchResultDict in array{
            let result = RecipeSearchResult(dict: recipeSearchResultDict)
            self.searchResults.append(result)
        }
    }
    
    func getURLFetchString() -> String{
        let ingredientStrings = self.ingridients.map{ $0.lowercased() }
        var URLString = "http://topmeal-142219.appspot.com/search?ingredients=" + ingredientStrings.joined(separator: ",").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        URLString = URLString + "&start=0"
        if vegan{
            URLString += "&vegan=1"
        }
        if diet {
            URLString += "&diet=1"
        }
        if noDairy {
            URLString += "&nodairy=1"
        }
        if noHoney {
            URLString += "&nohoney=1"
        }
        if noGluten {
            URLString += "&nogluten=1"
        }
        if noHoney {
            URLString += "&noHoney=1"
        }
        
        URLString += "&type=" + self.types.joined(separator: ",")
        
        return URLString
    }

    func count() -> Int {
        return self.searchResults.count
    }
    
    
    //#MARK: - Pagination

    func updateArray(array: [Dictionary<String, AnyObject>]) {
        for recipeSearchResultDict in array{
            let result = RecipeSearchResult(dict: recipeSearchResultDict)
            self.searchResults.append(result)
        }
    }
    
    func getURLMoreString() -> String{
        var URLString = getURLFetchString()
        URLString = URLString + "&start=" + String(self.searchResults.count)
        return URLString
    }

    
    
    /*
    func loadNextSearchResults(completed: @escaping (String) -> Void )  {
        
        let URLString = self.searchResultsURLString()
        print(URLString) //DEBUG
        if self.ingridients.count == 0 {
            completed("Не выбраны ингридиенты")
            return
        }
        Alamofire.request(URLString).responseJSON{ response in
            
            print(response.request) //DEBUG // original URL request
            print(response.response)//DEBUG // HTTP URL response
            print(response.data)  //DEBUG   // server data
            print(response.result) //DEBUG  // result of response serialization
            
            if let JSON = response.result.value {
                if let dict =  JSON as? Dictionary<String, AnyObject>{
                    if let searchResArray = dict["searchResults"] as? [Dictionary<String,AnyObject>] {
                        if searchResArray.count == 0 {
                            self.noMoreResults = true
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
    */
    /*
    func loadInitialSearchResults(completed: @escaping (String) -> Void )  {
        self.searchResults = []
        self.loadNextSearchResults(completed: completed)
        
    }*/

    
    
}
