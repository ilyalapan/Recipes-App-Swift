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
    case success = "successful"
    case unathorised = "unauthorised"
    case badRequest = "bad reqeust"
    case badResponse = "bad response"
    case other = "other"
    //TODO: expand
}

class RequestHelper { //TODO: possibly make this an extension of Alamofire
    
    static let helper = RequestHelper()
    
    static func checkResponse(responseJSON:  Alamofire.DataResponse<Any> ) -> ServerRequestResponse {
        if let JSON = responseJSON.result.value {
            if let dict =  JSON as? Dictionary<String, String>{
                if let status = ServerRequestResponse(rawValue: dict["status"]!) {
                    switch status {
                    case ServerRequestResponse.success:
                        return .success
                    case ServerRequestResponse.unathorised:
                        return .unathorised
                    case ServerRequestResponse.badRequest:
                        return .badRequest
                    default:
                        return .other
                    }
                }
            }
        }
        return .badResponse
    }

    
}
