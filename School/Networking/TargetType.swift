//
//  TargetType.swift
//  School
//
//  Created by Mahmoud on 01/12/2024.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum Task {
    
    //a request without any addition data
    case requestPlain
    
    //requeat body with with encoded parameters
    case requestParameters(parameters: [String : Any], encoding: ParameterEncoding)
}

protocol TargetType {
    //the target baseURLs
    var baseURL: String { get }
    
    //path to appead to `baseURL` to form the full `URL`
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var task: Task { get }

    var headers: [String: String]? { get }
}
