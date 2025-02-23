//
//  BaseModel.swift
//  School
//
//  Created by Mahmoud on 01/12/2024.
//

import Foundation

struct BaseModel: Codable {
    
    var error: Bool?
    var message: String?
}

struct BaseResponse<T:Codable>: Codable {

    var error: Bool?
    var message: String?
    var data: T?
    
}
