//
//  LoginNetworking.swift
//  School
//
//  Created by Mahmoud on 06/12/2024.
//


import Foundation
import Alamofire


enum LoginNetworking {
    case login(email: String, password: String, role: String)
}

extension LoginNetworking: TargetType {
    var baseURL: String {
        switch self {
        default:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
                .post
        }

    }
    
    var task: Task {
        switch self {
        case .login(email: let email, password: let password, role: let role):
                .requestParameters(parameters: ["email": email, "password": password, "role": role], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
}
