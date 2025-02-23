//
//  LoginAPI.swift
//  School
//
//  Created by Mahmoud on 06/12/2024.
//

import Foundation

protocol LoginAPIProtocol {
    func login(email: String, password: String, role: String,completion: @escaping (Result<LoginModel?, CustomError>) -> Void)
 
}


class LoginAPI: BaseAPI<LoginNetworking>, LoginAPIProtocol{
    func login(email: String, password: String, role: String, completion: @escaping (Result<LoginModel?, CustomError>) -> Void) {
        self.performRequest(target: .login(email: email, password: password, role: role), rsponseClass: LoginModel.self) { result in
            completion(result)
        }
    }
    
    
}
