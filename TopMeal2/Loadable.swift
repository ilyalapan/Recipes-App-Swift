//
//  Loadable.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 19/10/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import Foundation
import Alamofire

protocol Loadable {
    
    func load(idToken: String, completed: @escaping (ServerRequestResponse) -> Void )
    func getURLFetchString() -> String
    func loadArray(array: [Dictionary<String,AnyObject>] )
    
    func count() -> Int //count number of elements, supporting non trivial counting
    
}

extension Loadable {
    
    func load(idToken: String = "", completed: @escaping (ServerRequestResponse) -> Void )  {
        var headers : Dictionary<String,String> = [:]
        if idToken != "" {
            headers = ["Authorization": "Bearer " + idToken,]
        }
        let URLString = self.getURLFetchString()

        Alamofire.request(URLString, headers: headers).responseJSON{ response in
            
            do {
                let postsArray = try RequestHelper.checkResponse(responseJSON: response)
                self.loadArray(array: postsArray)
                completed(ServerRequestResponse.Success)
            }
            catch ServerResponseError.Unathorised {
                completed(ServerRequestResponse.Unathorised)
            }
            catch ServerResponseError.Empty {
                print("Empty")
                completed(ServerRequestResponse.Empty)
            } //TODO: Cath all the errors or it will crash!
            catch {
                assert(false, "Did not catch error with the response")
            }
        }
    }
    
}
