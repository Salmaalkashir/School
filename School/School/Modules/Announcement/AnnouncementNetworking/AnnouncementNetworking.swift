//
//  AnnouncementNetworking.swift
//  School
//
//  Created by Mahmoud on 08/03/2025.
//

import Foundation
import Alamofire

enum AnnouncementNetworking {
    case Announcement(email: String, password: String, role: String)
}

extension AnnouncementNetworking: TargetType {
    var baseURL: String {
        switch self {
        default:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .Announcement:
            return "login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .Announcement:
                .get
        }

    }
    
    var task: Task {
        switch self {
        case .Announcement(email: let email, password: let password, role: let role):
                .requestParameters(parameters: ["email": email, "password": password, "role": role], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
}
