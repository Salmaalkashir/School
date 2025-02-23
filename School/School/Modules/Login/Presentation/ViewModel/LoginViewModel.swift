//
//  LoginViewModel.swift
//  School
//
//  Created by Mahmoud on 06/12/2024.
//

import Foundation

protocol LoginViewModelProtocol {
    func login (email: String, Password: String, role: String) -> String
}

class LoginViewModel: LoginViewModelProtocol {
    var api: LoginAPIProtocol
    
    init(api: LoginAPI) {
        self.api = api
    }
    func login(email: String, Password: String, role: String) -> String {
        api.login(email: email, password: Password, role: role) { result in
            switch result{
            case .success(let result):
                print("mahmoud done this good")
                print(result)
            case.failure(let error):
                print("mahmoud fail to do anything")
                print(error)
            }
        }
        return ""
    }
    
}
