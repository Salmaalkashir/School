//
//  AnnouncementAPI.swift
//  School
//
//  Created by Mahmoud on 08/03/2025.
//

import Foundation

protocol AnnouncementAPIProtocol {
    func login(email: String, password: String, role: String,completion: @escaping (Result<LoginModel?, CustomError>) -> Void)
 
}


class AnnouncementAPI: BaseAPI<LoginNetworking>, AnnouncementAPIProtocol{
    func login(email: String, password: String, role: String, completion: @escaping (Result<LoginModel?, CustomError>) -> Void) {
        self.performRequest(target: .login(email: email, password: password, role: role), rsponseClass: LoginModel.self) { result in
            completion(result)
        }
    }
    
    
}
