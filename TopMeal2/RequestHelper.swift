//
//  RequestHelper.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 17/10/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import Foundation
import Alamofire

enum ServerRequestResponse: String {
    case Success = "successful"
    case Unathorised = "unauthorised"
    case BadRequest = "bad reqeust"
    case BadResponse = "bad response"
    case Other = "other"
    case Failed = "failed"
    case Empty = "empty"
    //TODO: expand
}

enum ServerResponseError : Error {
    case Unathorised
    case BadRequest
    case NoResponseStatus
    case BadResponse
    case Failed
    case Unknown
    case Empty
    
}

class RequestHelper { //TODO: possibly make this an extension of Alamofire
    
    static let helper = RequestHelper()
    
    static func checkResponse(responseJSON:  Alamofire.DataResponse<Any> ) throws -> [Dictionary<String, AnyObject>] {
        if let JSON = responseJSON.result.value {
            if let dict =  JSON as? Dictionary<String, AnyObject>{
                do {
                    try checkStatus(responseDict: dict)
                } catch ServerRequestResponse.Unathorised {
                    throw ServerResponseError.Unathorised
                }
                //TODO: catch all errors
                if let array = dict["result"] as! [Dictionary<String, AnyObject>]? {
                    return array
                }
            }
        }
        throw ServerResponseError.BadResponse
    }
    
    
    
    static func checkStatus(responseJSON: Alamofire.DataResponse<Any> ) throws  {
        if let JSON = responseJSON.result.value {
            if let dict =  JSON as? Dictionary<String, AnyObject>{
                do {
                    try checkStatus(responseDict: dict)
                    return
                }
            }
        }
        print("You didn't include reponse status in the backend implementation")
        throw ServerResponseError.NoResponseStatus
    }
    
    
    ///Checks the status of the response if passed a Dictionary of already serealised response from the server.
    ///Returns if response is valid, throws an error if there is a problem (Unathorised, BadRequest and etc)
    ///The server response has to have "status" key at the top of the tree, otherwise an error will be thrown.
    ///
    ///
    /// - parameter responseDict: dictionary wich contains "result" key
    ///
    /// - throws: see ServerResponseError
    static func checkStatus(responseDict: Dictionary<String, AnyObject> ) throws  {
        if let rawValue = responseDict["status"] {
            if let status = ServerRequestResponse(rawValue: rawValue as! String) {
                switch status {
                case ServerRequestResponse.Success:
                    return
                case ServerRequestResponse.Unathorised:
                    print("User is no authorised")
                    throw ServerResponseError.Unathorised
                case ServerRequestResponse.BadRequest:
                    print("You made a bad request to the server")
                    throw ServerResponseError.BadRequest
                case ServerRequestResponse.Failed:
                    print("Back-end failed the operation for a known reason")
                    throw ServerResponseError.Failed
                case ServerRequestResponse.Empty:
                    print("Back-end failed the operation for a known reason")
                    throw ServerResponseError.Empty
                default:
                    print("Unknown error")
                    throw ServerResponseError.Unknown
                }
            }
        }
        print("You didn't include reponse status in the backend implementation")
        throw ServerResponseError.NoResponseStatus
    }
    //TODO: perform unit tests
    
    
}
