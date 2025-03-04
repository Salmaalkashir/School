//
//  LoginViewModel.swift
//  School
//
//  Created by Mahmoud on 06/12/2024.
//

import Foundation

protocol LoginViewModelProtocol {
    func login(email: String, Password: String, role: String) -> String
    var result: LoginModel? { get set }
    var bindDataToController: (()->()) {get set}
}

class LoginViewModel: LoginViewModelProtocol {
    var api: LoginAPIProtocol

    init(api: LoginAPI) {
        self.api = api
    }
    var result: LoginModel? {
        didSet {
            self.bindDataToController()
        }
    }
    var bindDataToController: (() -> ()) = {}
    
    
    
    func login(email: String, Password: String, role: String) -> String {
        api.login(email: email, password: Password, role: role) { result in
            switch result {
            case let .success(result):
                print("mahmoud done this good")
                print(result)
                self.result = result
            case let .failure(error):
                print("mahmoud fail to do anything")
                print(error)
                
            }
        }
        return ""
    }
}
